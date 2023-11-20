unit ulogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  Tflogin = class(TForm)
    Image1: TImage;
    Edit3: TEdit;
    Button1: TButton;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  flogin: Tflogin;

implementation

uses udm, umenu;

{$R *.dfm}

procedure Tflogin.Button1Click(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from konfigurasi where id_konfigurasi =1';
dm.ADOQuery1.Open;
if edit3.Text <> dm.ADOQuery1['password'] then
begin
 application.MessageBox('Password Salah!','Informasi!',mb_ok or mb_iconinformation);
 edit3.SetFocus;
end
else
begin
fmenu.omset;
fmenu.Show;
fmenu.omset;
hide;
edit3.Clear;
end;
end;

procedure Tflogin.FormShow(Sender: TObject);
begin
edit3.Clear;
edit3.SetFocus;
end;

procedure Tflogin.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then button1.Click;
end;

procedure Tflogin.Image2Click(Sender: TObject);
begin
application.Terminate;
end;

end.
