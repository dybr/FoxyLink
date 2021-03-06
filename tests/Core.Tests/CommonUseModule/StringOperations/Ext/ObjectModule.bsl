﻿Var CoreContext;
Var Assertions;

#Region ServiceInterface

Procedure Инициализация(CoreContextParam) Export
    
    CoreContext = CoreContextParam;
    Assertions = CoreContext.Плагин("БазовыеУтверждения");
    
EndProcedure // Инициализация()

Procedure ЗаполнитьНаборТестов(TestsSet) Export
    
    TestsSet.Добавить("Fact_IsSpecSymbol_Code_0");
    TestsSet.Добавить("Fact_IsSpecSymbol_Code_33");
    TestsSet.Добавить("Fact_IsSpecSymbol_Code_256");
    
    TestsSet.Добавить("Fact_IsNumber_0");
    TestsSet.Добавить("Fact_IsNumber_9");
    
    TestsSet.Добавить("Fact_IsLatinLetter_A");
    TestsSet.Добавить("Fact_IsLatinLetter_smallA");
    TestsSet.Добавить("Fact_IsLatinLetter_Z");
    TestsSet.Добавить("Fact_IsLatinLetter_smallZ");
    
    TestsSet.Добавить("Fact_IsCyrillicLetter_А");
    TestsSet.Добавить("Fact_IsCyrillicLetter_smallЯ");
    
    
    TestsSet.Добавить("Fact_IsIncorrectVariableName_1");
    TestsSet.Добавить("Fact_IsIncorrectVariableName_2");
    TestsSet.Добавить("Fact_IsIncorrectVariableName_3");
    TestsSet.Добавить("Fact_IsCorrectVariableName");

    
EndProcedure // ЗаполнитьНаборТестов()

#EndRegion // ServiceInterface

#Region TestCases

Procedure Fact_IsSpecSymbol_Code_0() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsSpecialSymbol(Char(0)));
    
EndProcedure // Fact_IsSymbol_Code_0()

Procedure Fact_IsSpecSymbol_Code_33() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsSpecialSymbol(Char(33)));
    
EndProcedure // Fact_IsSymbol_Code_33()

Procedure Fact_IsSpecSymbol_Code_256() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsSpecialSymbol(Char(256)));
    
EndProcedure // Fact_IsSpecSymbol_Code_256()


Procedure Fact_IsNumber_0() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsNumber("0"));
    
EndProcedure // Fact_IsNumber_0()

Procedure Fact_IsNumber_9() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsNumber("9"));
    
EndProcedure // Fact_IsNumber_9()


Procedure Fact_IsLatinLetter_A() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsLatinLetter("A"));
    
EndProcedure // Fact_IsLatinLetter_A()

Procedure Fact_IsLatinLetter_smallA() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsLatinLetter("a"));
    
EndProcedure // Fact_IsLatinLetter_smallA()

Procedure Fact_IsLatinLetter_Z() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsLatinLetter("Z"));
    
EndProcedure // Fact_IsLatinLetter_Z()

Procedure Fact_IsLatinLetter_smallZ() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsLatinLetter("z"));
    
EndProcedure // Fact_IsLatinLetter_smallZ()


Procedure Fact_IsCyrillicLetter_А() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsCyrillicLetter("А"));
    
EndProcedure // Fact_IsCyrillicLetter_А()

Procedure Fact_IsCyrillicLetter_smallЯ() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsCyrillicLetter("я"));
    
EndProcedure // Fact_IsCyrillicLetter_smallЯ()


Procedure Fact_IsIncorrectVariableName_1() Export
    
    Assertions.ПроверитьЛожь(FL_CommonUseClientServer.IsCorrectVariableName("Гаt_#sd1"));
    
EndProcedure // Fact_IsIncorrectVariableName_1()

Procedure Fact_IsIncorrectVariableName_2() Export
    
    Assertions.ПроверитьЛожь(FL_CommonUseClientServer.IsCorrectVariableName("1fABb"));
    
EndProcedure // Fact_IsIncorrectVariableName_2()

Procedure Fact_IsIncorrectVariableName_3() Export
    
    Assertions.ПроверитьЛожь(FL_CommonUseClientServer.IsCorrectVariableName("_1 x"));
    
EndProcedure // Fact_IsIncorrectVariableName_3()

Procedure Fact_IsCorrectVariableName() Export
    
    Assertions.ПроверитьИстину(FL_CommonUseClientServer.IsCorrectVariableName("_1_hFФа"));
    
EndProcedure // Fact_IsCorrectVariableName()

#EndRegion // TestCases