unit uobat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, jpeg, ExtCtrls;

type
  Tfobat = class(TForm)
    Image1: TImage;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbiaya: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    UpDown1: TUpDown;
    procedure hapus;
    procedure mati;
    procedure aktif;
    procedure ree;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fobat: Tfobat;

implementation

uses udm, umenu;

{$R *.dfm}

procedure Tfobat.aktif;
begin
edit1.Enabled := true;
edit2.Enabled := true;
edit3.Enabled := true;
edit4.Enabled := true;
edit5.Enabled := true;
edit6.Enabled := true;
end;

procedure Tfobat.hapus;
begin
edit1.Clear;
edit2.Clear;
edit3.Clear;
edit4.Clear;
edit5.Clear;
edit6.Clear;
end;

procedure Tfobat.mati;
begin
edit1.Enabled := false;
edit2.Enabled := false;
edit3.Enabled := false;
edit4.Enabled := false;
edit5.Enabled := false;
edit6.Enabled := false;
end;

procedure Tfobat.ree;
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat';
dm.ADOQuery1.Open;
end;

procedure Tfobat.FormShow(Sender: TObject);
begin
edit7.Clear;
hapus;
mati;
ree;
end;

procedure Tfobat.BitBtn1Click(Sender: TObject);
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
procedure Tfobat.BitBtn2Click(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat ='+quotedstr(edit1.Text)+'';
dm.ADOQuery1.Open;

if (edit1.Text = NULL) or (edit2.Text = '') or (edit3.Text = '') or (edit4.Text = '') or (edit5.Text = '')or (edit6.Text = '') then
application.MessageBox('Masih ada data yang belum terisi','Informasi!',mb_ok or mb_iconinformation) else
if edit1.Enabled = true then
 begin
 if edit1.Text = dm.ADOQuery1['kode_obat'] then
 begin
 application.MessageBox('Kode obat sudah ada!','Informasi!',mb_ok or mb_iconinformation);
 edit1.SetFocus;
 end else
 begin
  dm.ADOQuery1.Append;
  dm.ADOQuery1['kode_obat'] := edit1.Text;
  dm.ADOQuery1['nama'] := edit2.Text;
  dm.ADOQuery1['lokasi'] := edit3.Text;
  dm.ADOQuery1['harga_beli'] := edit4.Text;
  dm.ADOQuery1['harga_jual'] := edit5.Text;
  dm.ADOQuery1['stok'] := edit6.Text;
  dm.ADOQuery1.Post;
  application.MessageBox('Data obat sudah tersimpan!','Informasi!',mb_ok or mb_iconinformation);
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
  dm.ADOQuery1.Edit;
  dm.ADOQuery1['kode_obat'] := edit1.Text;
  dm.ADOQuery1['nama'] := edit2.Text;
  dm.ADOQuery1['lokasi'] := edit3.Text;
  dm.ADOQuery1['harga_beli'] := edit4.Text;
  dm.ADOQuery1['harga_jual'] := edit5.Text;
  dm.ADOQuery1['stok'] := edit6.Text;
  dm.ADOQuery1.Post;
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
ree;
end;

procedure Tfobat.Edit1Change(Sender: TObject);
begin
if edit1.Enabled = true then
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat ='+quotedstr(edit1.Text)+'';
dm.ADOQuery1.Open;
  if edit1.Text = dm.ADOQuery1['kode_obat'] then
  begin
    application.MessageBox('Kode obat sudah ada!','Informasi!',mb_ok or mb_iconinformation);
    edit1.SetFocus;
  end;
 ree;
end;
end;

procedure Tfobat.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then edit5.SetFocus;
if (key in['a'..'z','A'..'Z',#32]) then
  begin
    key:=#0;
    application.MessageBox('Input data harus berisi angka!','Informasi!',mb_ok or mb_iconinformation);
  end;
end;

procedure Tfobat.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then edit6.SetFocus;
if (key in['a'..'z','A'..'Z',#32]) then
  begin
    key:=#0;
    application.MessageBox('Input data harus berisi angka!','Informasi!',mb_ok or mb_iconinformation);
  end;
end;


procedure Tfobat.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then bitbtn1.Click;
if (key in['a'..'z','A'..'Z',#32]) then
  begin
    key:=#0;
    application.MessageBox('Input data harus berisi angka!','Informasi!',mb_ok or mb_iconinformation);
  end;
end;

procedure Tfobat.BitBtn3Click(Sender: TObject);
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

procedure Tfobat.DBGrid1DblClick(Sender: TObject);
begin
aktif;
edit1.Enabled := false;
edit6.Enabled := false;
edit1.Text := dm.ADOQuery1['kode_obat'];
edit2.Text := dm.ADOQuery1['nama'];
edit3.Text := dm.ADOQuery1['lokasi'];
edit4.Text := dm.ADOQuery1['harga_beli'];
edit5.Text := dm.ADOQuery1['harga_jual'];
edit6.Text := dm.ADOQuery1['stok'];


bitbtn1.Caption := '&Batal';
bitbtn2.Enabled := true;
bitbtn2.Caption := '&Update';
bitbtn3.Caption := '&Hapus';
end;

procedure Tfobat.Edit7Change(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat like '+quotedstr('%'+edit7.Text+'%')+' or nama like '+quotedstr('%'+edit7.Text+'%')+'';
dm.ADOQuery1.Open;
end;

procedure Tfobat.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then edit2.SetFocus;
end;

procedure Tfobat.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then edit3.SetFocus;
end;

procedure Tfobat.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then edit4.SetFocus;
end;

end.
