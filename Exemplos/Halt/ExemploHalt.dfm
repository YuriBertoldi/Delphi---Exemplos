object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo funcionamento Halt'
  ClientHeight = 170
  ClientWidth = 865
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 839
    Height = 33
    Caption = 
      'Halt '#233' a '#250'nica maneira de n'#227'o entrar em um finally no delphi, el' +
      'e encerra a aplica'#231#227'o abruptamente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 40
    Top = 119
    Width = 785
    Height = 25
    Caption = 
      'Try finally com halt e gravando arquivo Log.txt dentro do finall' +
      'y'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 88
    Width = 785
    Height = 25
    Caption = 
      'Try finally com application terminate e gravando Log.txt dentro ' +
      'do finally'
    TabOrder = 1
    OnClick = Button2Click
  end
end
