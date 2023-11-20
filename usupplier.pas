unit usupplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, jpeg, ExtCtrls;

type
  Tfsupplier = class(TForm)
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    Edit7: TEdit;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure ree;
    procedure hapus;
    procedure mati;
    procedure aktif;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fsupplier: Tfsupplier;

implementation

uses udm, umenu;

{$R *.dfm}

procedure Tfsupplier.ree;
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from supplier';
dm.ADOQuery1.Open;
end;

procedure Tfsupplier.FormShow(Sender: TObject);
begin
edit1.Clear;
edit7.Clear;
hapus;
mati;
ree;
end;

procedure Tfsupplier.hapus;
begin
edit1.Clear;
end;

procedure Tfsupplier.mati;
begin
edit1.Enabled := false;
end;

procedure Tfsupplier.aktif;
begin
edit1.Enabled := true;
end;

procedure Tfsupplier.BitBtn1Click(Sender: TObject);
begin
if bitbtn1.Caption = '&Tambah' then
begin
  bitbtn1.Caption := '&Batal';
  bitbtn2.Enabled := true;
  bitbtn3.Enabled := false;
  aktif;
  edit1.SetFocus;
end else
begin
  bitbtn2.Caption := '&Simpan';
  bitbtn1.Caption := '&Tambah';
  bitbtn2.Enabled := false;
  bitbtn3.Enabled := true;
  bitbtn3.Caption := '&Keluar';
  mati;
  hapus;
end;
end;

procedure Tfsupplier.BitBtn2Click(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from supplier where supplier ='+quotedstr(edit1.Text)+'';
dm.ADOQuery1.Open;

if (edit1.Text = '') then
application.MessageBox('Masih ada data yang belum terisi','Informasi!',mb_ok or mb_iconinformation) else
if bitbtn2.Caption = '&Simpan' then
 begin
  if edit1.Text = dm.ADOQuery1['supplier'] then
  begin
    application.MessageBox('Nama supplier sudah ada!','Informasi!',mb_ok or mb_iconinformation);
    edit1.SetFocus;
  end else
  begin
    dm.ADOQuery1.Append;
    dm.ADOQuery1['supplier'] := edit1.Text;
    dm.ADOQuery1.Post;
    application.MessageBox('Supplier sudah tersimpan!','Informasi!',mb_ok or mb_iconinformation);
    HAPUS;
    mati;
    bitbtn2.Caption := '&Simpan';
    bitbtn3.Enabled := true;
    bitbtn3.Caption := '&Keluar';
    bitbtn1.Caption := '&Tambah';
    bitbtn2.Enabled := false;
    bitbtn3.Enabled := true;
    ree;
  end;
 end else
  begin
  dm.ADOQuery1.Close;
  dm.ADOQuery1.SQL.Clear;
  dm.ADOQuery1.SQL.Text := 'UPDATE supplier set supplier = '+quotedstr(edit1.Text)+' where id_supplier = '+edit2.Text+'';
  dm.ADOQuery1.ExecSQL;
  HAPUS;
  mati;
  bitbtn2.Caption := '&Simpan';
  bitbtn3.Enabled := true;
  bitbtn3.Caption := '&Keluar';
  bitbtn1.Caption := '&Tambah';
  bitbtn2.Enabled := false;
  bitbtn3.Enabled := true;
  application.MessageBox('Nama supplier berhasil diperbarui!','Informasi!',mb_ok or mb_iconinformation);
  ree;
  edit2.Clear;
  end;
ree;
end;

procedure Tfsupplier.BitBtn3Click(Sender: TObject);
begin
if bitbtn3.Caption = '&Hapus' then
begin
  dm.ADOQuery1.Delete;
  application.MessageBox('Data sudah terhapus!','Informasi!',mb_ok or mb_iconinformation);
  HAPUS;
  mati;
  bitbtn2.Caption := '&Simpan';
  bitbtn3.Enabled := true;
  bitbtn3.Caption := '&Keluar';
  bitbtn1.Caption := '&Tambah';
  bitbtn2.Enabled := false;
  bitbtn3.Enabled := true;
  ree;
end else
begin
  fmenu.show;
  hide;
end;
end;

procedure Tfsupplier.DBGrid1DblClick(Sender: TObject);
begin
aktif;
edit1.Enabled := true;
edit1.Text := dm.ADOQuery1['supplier'];
edit2.Text := dm.ADOQuery1['id_supplier'];

bitbtn1.Caption := '&Batal';
bitbtn2.Enabled := true;
bitbtn2.Caption := '&Update';
bitbtn3.Caption := '&Hapus';
end;

procedure Tfsupplier.Edit7Change(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from supplier where supplier like '+quotedstr('%'+edit7.Text+'%')+' or id_supplier like '+quotedstr('%'+edit7.Text+'%')+'';
dm.ADOQuery1.Open;
end;

end.
