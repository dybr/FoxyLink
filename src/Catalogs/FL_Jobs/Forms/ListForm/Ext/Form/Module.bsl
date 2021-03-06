﻿////////////////////////////////////////////////////////////////////////////////
// This file is part of FoxyLink.
// Copyright © 2016-2018 Petro Bazeliuk.
// 
// This program is free software: you can redistribute it and/or modify 
// it under the terms of the GNU Affero General Public License as 
// published by the Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful, 
// but WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License 
// along with FoxyLink. If not, see <http://www.gnu.org/licenses/agpl-3.0>.
//
////////////////////////////////////////////////////////////////////////////////

#Region FormEventHandlers

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
    
    SafeMode = True;
    UpdateJobServerStateAtServer();   
    
EndProcedure // OnCreateAtServer()

&AtClient
Procedure OnOpen(Cancel)
    
    AttachIdleHandler("UpdateJobServerState", 5, False);
    
EndProcedure // OnOpen()

#EndRegion // FormEventHandlers 

#Region FormCommandHandlers

// See function Catalogs.FL_Jobs.Trigger.
//
&AtClient
Procedure TriggerSelectedMessages(Command)
    
    CurrentData = Items.List.CurrentData;
    If CurrentData <> Undefined Then
        TriggerSelectedMessagesAtServer(Items.List.SelectedRows);
    Else
        FL_CommonUseClientServer.NotifyUser(NStr("en='Select a message to process from the list.';
            |ru='Выберите сообщение для обработки из списка.';
            |en_CA='Select a message to process from the list.'"));
    EndIf;
    
EndProcedure // TriggerSelectedMessages()

// See function Catalogs.FL_Jobs.Trigger.
//
&AtClient
Procedure TriggerMessages(Command)
    
    TriggerMessagesAtServer();
    
EndProcedure // TriggerMessages()

// See procedure FL_JobServer.RunJobServer.
//
&AtClient
Procedure StartJobServer(Command)
    
    StartJobServerAtServer();
    
EndProcedure // StartJobServer()

// See procedure FL_JobServer.StopJobServer.
//
&AtClient
Procedure StopJobServer(Command)
    
    StopJobServerAtServer();
        
    ShowUserNotification(
        NStr("en='Job server (FoxyLink)';
            |ru='Сервер заданий (FoxyLink)';
            |uk='Сервер завдань (FoxyLink)';
            |en_CA='Job server (FoxyLink)'"),
        ,
        NStr("en='Job server is stopped, but the stopped status will be set by the server just in a few seconds.';
            |ru='Сервер заданий остановлен, но состояние остановки будет установлено сервером через несколько секунд.';
            |uk='Сервер завдань зупинено, але стан зупинки буде встановлено сервером через декілька секунд.';
            |en_CA='Job server is stopped, but the stopped status will be set by the server just in a few seconds.'"),
        PictureLib.FL_Logotype64
        );
         
EndProcedure // StopJobServer()

#EndRegion // FormCommandHandlers

#Region ServiceProceduresAndFunctions

// Only for internal use.
//
&AtClient
Procedure UpdateJobServerState() Export
    
    UpdateJobServerStateAtServer();
    
EndProcedure // UpdateJobServerState() 

// Only for internal use.
//
&AtServer
Procedure UpdateJobServerStateAtServer()
     
    If FL_JobServer.ServerWatchDog(FL_JobServer.JobServer()) Then
        Items.GroupJobServerPages.CurrentPage = Items.GroupJobServerRunning;
    Else
        Items.GroupJobServerPages.CurrentPage = Items.GroupJobServerStopped; 
    EndIf;
    
EndProcedure // UpdateJobServerStateAtServer() 

// See function Catalogs.FL_Jobs.Trigger.
//
&AtServer
Procedure TriggerSelectedMessagesAtServer(Val Jobs)

    For Each Job In Jobs Do
        Catalogs.FL_Jobs.Trigger(Job);
    EndDo;

EndProcedure // TriggerSelectedMessagesAtServer() 

// See function Catalogs.FL_Jobs.Trigger.
//
&AtServer
Procedure TriggerMessagesAtServer()
    
    Query = New Query;
    Query.Text = "
        |SELECT
        |   BackgroundJobs.Ref AS Ref
        |FROM
        |   Catalog.FL_Jobs AS BackgroundJobs
        |WHERE
        |    BackgroundJobs.DeletionMark = FALSE
        |AND BackgroundJobs.State = Value(Catalog.FL_States.Enqueued)
        |";
    QueryResult = Query.Execute();
    
    SelectionDetailRecords = QueryResult.Select();
    While SelectionDetailRecords.Next() Do
        Catalogs.FL_Jobs.Trigger(SelectionDetailRecords.Ref);
    EndDo;
  
EndProcedure // TriggerMessagesAtServer() 

// See procedure FL_JobServer.RunJobServer.
// 
&AtServer
Procedure StartJobServerAtServer()
    
    FL_JobServer.RunJobServer(SafeMode); 
    UpdateJobServerStateAtServer();
    
EndProcedure // StartJobServerAtServer()

// See procedure FL_JobServer.StopJobServer.
//
&AtServer
Procedure StopJobServerAtServer()
    
    FL_JobServer.StopJobServer();
    
EndProcedure // StopJobServerAtServer() 

#EndRegion // ServiceProceduresAndFunctions