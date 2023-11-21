unit upembelian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, DBGrids, jpeg, ExtCtrls,
  DBCtrls;

type
  Tfpembelian = class(TForm)
    Image1: TImage;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    lbiaya: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit7: TEdit;
    UpDown1: TUpDown;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ltagihan: TLabel;
    edit1: TComboBox;
    procedure ree;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fpembelian: Tfpembelian;
  kodeobat : string;
  harga_beli, harga_jual, tagihan, stok1, stok2 : real;
implementation

uses umenu, udm;

{$R *.dfm}

procedure Tfpembelian.BitBtn3Click(Sender: TObject);
begin
if bitbtn3.Caption = '&Batal' then
begin
  application.MessageBox('Transaksi pembelian dibatalkan!','Informasi!',mb_ok or mb_iconinformation);
  bitbtn1.Caption := '&Tambah Stok';
  bitbtn3.Enabled := true;
  bitbtn3.Caption := '&Keluar';
  bitbtn1.Enabled := false;
  bitbtn3.Enabled := true;
  edit2.Clear;
  edit1.Visible := false;
  edit2.Visible := false;
  label6.Visible := false;
  label4.Visible := false;
  ltagihan.Visible := false;
  updown1.Visible := false;
  ree;
end else
begin
  fmenu.show;
  hide;
end;
end;

procedure Tfpembelian.ree;
begin
label7.Caption := '_______';
label8.Caption := '_______';
label9.Caption := '_______';
label10.Caption := '_______';
label11.Caption := '_______';
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat';
dm.ADOQuery1.Open;
  edit1.Items.Clear;
  dm.adosup.Open; // Membuka query
  dm.adosup.First; // Pindah ke record pertama
  while not dm.adosup.Eof do
  begin
    edit1.Items.Add(dm.adosup.FieldByName('supplier').AsString);
    dm.adosup.Next;
  end;
end;

procedure Tfpembelian.FormShow(Sender: TObject);
begin
edit7.Clear;
edit2.Clear;
edit1.Visible := false;
edit2.Visible := false;
updown1.Visible := false;
label4.Visible := false;
label6.Visible := false;
ltagihan.Visible := false;
ree;
end;

procedure Tfpembelian.Edit7Change(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat like '+quotedstr('%'+edit7.Text+'%')+' or nama like '+quotedstr('%'+edit7.Text+'%')+'';
dm.ADOQuery1.Open;
end;

procedure Tfpembelian.DBGrid1DblClick(Sender: TObject);
begin
label7.Caption := dm.ADOQuery1['kode_obat'];
label8.Caption := dm.ADOQuery1['nama'];
label9.Caption := 'Rp. '+formatcurr('#,###',dm.ADOQuery1['harga_beli']);
label10.Caption := 'Rp. '+formatcurr('#,###',dm.ADOQuery1['harga_jual']);
label11.Caption := dm.ADOQuery1['stok'];

kodeobat := dm.ADOQuery1['kode_obat'];
harga_beli := strtofloat(dm.ADOQuery1['harga_beli']);
harga_jual := strtofloat(dm.ADOQuery1['harga_jual']);
stok1 := dm.ADOQuery1['stok'];
bitbtn1.Enabled := true;
bitbtn1.Caption := '&Tambah Stok';
bitbtn3.Caption := '&Batal';
edit2.Clear;
edit1.Visible := true;
edit2.Visible := true;
edit2.Text := '0';
label4.Visible := true;
label6.Visible := true;
updown1.Visible := true;
ltagihan.Visible := true;
ltagihan.Caption := '0';
edit1.SetFocus;
end;

procedure Tfpembelian.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then bitbtn1.Click;
if (key in['a'..'z','A'..'Z',#32]) then
  begin
    key:=#0;
    application.MessageBox('Input data harus berisi angka!','Informasi!',mb_ok or mb_iconinformation);
  end;
end;

procedure Tfpembelian.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then edit2.setFocus;
end;

procedure Tfpembelian.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
tagihan := harga_beli*strtofloat(edit2.Text);
ltagihan.Caption := floattostr(tagihan);
end;

procedure Tfpembelian.BitBtn1Click(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from pembelian';
dm.ADOQuery1.Open;
if (edit1.Text = 'pilih supplier') or (edit2.Text = '0') then
application.MessageBox('Masih ada data yang belum terisi','Informasi!',mb_ok or mb_iconinformation) else
 begin
  dm.ADOQuery1.Append;
  dm.ADOQuery1['supplier'] := edit1.Text;
  dm.ADOQuery1['kode_obat'] := kodeobat;
  dm.ADOQuery1['jumlah'] := edit2.Text;
  dm.ADOQuery1['tagihan'] := floattostr(strtofloat(edit2.Text)*harga_beli);
  dm.ADOQuery1['tanggal'] := FormatDateTime('dd/mm/yyyy', now);
  dm.ADOQuery1.Post;

  dm.ADOQuery1.Close;
  dm.ADOQuery1.SQL.Clear;
  dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat ='+quotedstr(kodeobat)+'';
  dm.ADOQuery1.Open;
  dm.ADOQuery1.Edit;
  dm.ADOQuery1['stok'] := floattostr(strtofloat(edit2.Text)+stok1);
  dm.ADOQuery1.Post;
  application.MessageBox('Transaksi pembelian stok obat telah berhasil!','Informasi!',mb_ok or mb_iconinformation);
  bitbtn1.Caption := '&Tambah Stok';
  bitbtn3.Enabled := true;
  bitbtn3.Caption := '&Keluar';
  bitbtn1.Enabled := false;
  bitbtn3.Enabled := true;
  edit2.Clear;
  edit1.Visible := false;
  edit2.Visible := false;
  label6.Visible := false;
  label4.Visible := false;
  ltagihan.Visible := false;
  updown1.Visible := false;
  ree;
 end;
 dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat';
dm.ADOQuery1.Open;
end;

procedure Tfpembelian.Edit2Change(Sender: TObject);
begin
if edit2.Text > '0' then
tagihan := harga_beli*strtofloat(edit2.Text);
ltagihan.Caption := 'Rp. '+formatcurr('#,###',tagihan);
end;

end.
