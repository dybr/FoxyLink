﻿////////////////////////////////////////////////////////////////////////////////
// This file is part of FoxyLink.
// Copyright © 2018 Petro Bazeliuk.
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

#Region EventHandlers

&AtClient
Procedure CommandProcessing(CommandParameter, CommandExecuteParameters)
    
    FormName = "DataProcessor.SocialNetworks_AdministrationPanel.Form.CommonSettings";
    Uniqueness = FormName + ?(CommandExecuteParameters.Window = Undefined, 
        ".SingleWindow", "");
    OpenForm(FormName, New Structure, CommandExecuteParameters.Source, 
        Uniqueness, CommandExecuteParameters.Window);
    
EndProcedure // CommandProcessing()

#EndRegion // EventHandlers

