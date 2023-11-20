unit umenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, StdCtrls, ComCtrls, XPMan;

type
  Tfmenu = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    DataObat1: TMenuItem;
    Penjualan1: TMenuItem;
    Pembelian1: TMenuItem;
    Laporan1: TMenuItem;
    Penjualan2: TMenuItem;
    Pembelian2: TMenuItem;
    DataObat2: TMenuItem;
    Pengaturan1: TMenuItem;
    Keluar1: TMenuItem;
    lnama: TLabel;
    lalamat: TLabel;
    gkonfigurasi: TGroupBox;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Image3: TImage;
    Label5: TLabel;
    Button4: TButton;
    ComboBox1: TComboBox;
    Button3: TButton;
    lhari: TLabel;
    lbulan: TLabel;
    Label6: TLabel;
    ljam: TLabel;
    Label22: TLabel;
    lmin: TLabel;
    Label24: TLabel;
    ldet: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    CBFilter: TComboBox;
    DTAwal: TDateTimePicker;
    DTAkhir: TDateTimePicker;
    Button5: TButton;
    Button6: TButton;
    Image4: TImage;
    GroupBox3: TGroupBox;
    Image5: TImage;
    Label13333: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ComboBox2: TComboBox;
    tgl1: TDateTimePicker;
    tgl2: TDateTimePicker;
    Button7: TButton;
    Button8: TButton;
    tgl: TDateTimePicker;
    Image6: TImage;
    Image8: TImage;
    Image9: TImage;
    XPManifest1: TXPManifest;
    Timer1: TTimer;
    Image7: TImage;
    procedure sql;
    procedure omset;
    procedure DataObat1Click(Sender: TObject);
    procedure Penjualan1Click(Sender: TObject);
    procedure Pembelian1Click(Sender: TObject);
    procedure Keluar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Pengaturan1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DataObat2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CBFilterChange(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure DTAwalChange(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Pembelian2Click(Sender: TObject);
    procedure Penjualan2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure tgl1Change(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmenu: Tfmenu;
  sintak,sintak2 : string;

implementation

uses uobat, upenjualan, upembelian, DateUtils, udm, ulogin, ulaporan,
  usupplier;

{$R *.dfm}

procedure Tfmenu.DataObat1Click(Sender: TObject);
begin
fobat.Show;
hide;
end;

procedure Tfmenu.Penjualan1Click(Sender: TObject);
begin
fpenjualan.Show;
hide;
end;

procedure Tfmenu.Pembelian1Click(Sender: TObject);
begin
fpembelian.Show;
hide;
end;

procedure Tfmenu.Keluar1Click(Sender: TObject);
begin
application.Terminate;
end;

procedure Tfmenu.omset;
var omset1 : real;
begin
  Sintak2:= 'select * from penjualan where'+
  ' tanggal>=#'+FormatDateTime('yyyy/MM/dd',tgl.Date)+'# and tanggal<=#'+FormatDateTime('yyyy/MM/dd',tgl.Date+1)+'#';
  sql;
  if not dm.ADOQuery1.Eof then
    begin
      Sintak2:= 'select sum(tagihan) as angka from penjualan where'+
      ' tanggal>=#'+FormatDateTime('yyyy/MM/dd',tgl.Date)+'# and tanggal<=#'+FormatDateTime('yyyy/MM/dd',tgl.Date+1)+'#';
      sql;
      omset1 := dm.ADOQuery1['angka'];
      lhari.Caption := 'Rp. '+formatcurr('#,###',omset1);
    end else
    lhari.Caption := '0';
  Sintak2:= 'select * from penjualan where'+
  ' month(tanggal)='+FormatDateTime('MM',tgl.Date)+' and year(tanggal)='+FormatDateTime('yyyy',tgl.Date)+'';
  sql;
  if not dm.ADOQuery1.Eof then
    begin
      Sintak2:= 'select sum(tagihan) as angka from penjualan where'+
      ' month(tanggal)='+FormatDateTime('MM',tgl.Date)+' and year(tanggal)='+FormatDateTime('yyyy',tgl.Date)+'';
       sql;
      omset1 := dm.ADOQuery1['angka'];
      lbulan.Caption := 'Rp. '+formatcurr('#,###',omset1);
    end else
    lbulan.Caption := '0';
end;

procedure Tfmenu.sql;
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := sintak2;
dm.ADOQuery1.Open;
end;


procedure Tfmenu.FormShow(Sender: TObject);
var
nama,alamat,no : string;
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from konfigurasi where id_konfigurasi =1';
dm.ADOQuery1.Open;
nama := dm.ADOQuery1['nama_apotek'];
alamat := dm.ADOQuery1['alamat'];
no := dm.ADOQuery1['no'];

lnama.Caption := nama;
lalamat.Caption := alamat;
omset;
gkonfigurasi.Visible := false;
groupbox1.Visible := false;
groupbox2.Visible := false;
groupbox3.Visible := false;
tgl.Date := now;
CBFilter.ItemIndex:=0;
DTAkhir.Date:=EndOfTheMonth(now);
DTAwal.Date:=StartOfTheMonth(now);
combobox2.ItemIndex:=0;
tgl2.Date:=EndOfTheMonth(now);
tgl1.Date:=StartOfTheMonth(now);
label6.Caption := datetostr(tgl.Date);
end;

procedure Tfmenu.Pengaturan1Click(Sender: TObject);
begin
gkonfigurasi.Visible := true;
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from konfigurasi where id_konfigurasi =1';
dm.ADOQuery1.Open;
edit1.Text := dm.ADOQuery1['nama_apotek'];
edit2.Text := dm.ADOQuery1['alamat'];
edit3.Text := dm.ADOQuery1['no'];
edit4.Text := dm.ADOQuery1['password'];
end;

procedure Tfmenu.Button2Click(Sender: TObject);
begin
gkonfigurasi.Visible := false;
end;

procedure Tfmenu.Button1Click(Sender: TObject);
begin
dm.ADOQuery1.Edit;
  dm.ADOQuery1['nama_apotek'] := edit1.Text;
  dm.ADOQuery1['alamat'] := edit2.Text;
  dm.ADOQuery1['no'] := edit3.Text;
  dm.ADOQuery1['password'] := edit4.Text;
  dm.ADOQuery1.Post;
  application.MessageBox('Pengaturan berhasil diperbarui!','Informasi!',mb_ok or mb_iconinformation);
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from konfigurasi where id_konfigurasi =1';
dm.ADOQuery1.Open;
lnama.Caption := dm.ADOQuery1['nama_apotek'];
lalamat.Caption := dm.ADOQuery1['alamat'];
end;

procedure Tfmenu.DataObat2Click(Sender: TObject);
begin
groupbox1.Visible := true;
combobox1.Text := 'Ada';
end;

procedure Tfmenu.Button4Click(Sender: TObject);
begin
groupbox1.Visible := false;
end;

procedure Tfmenu.Button3Click(Sender: TObject);
var stok : integer;
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
if combobox1.Text = 'Ada' then
  dm.ADOQuery1.SQL.Text := 'select*from obat where stok > 0' else
  dm.ADOQuery1.SQL.Text := 'select*from obat where stok = 0';
dm.ADOQuery1.Open;
if dm.ADOQuery1.RecordCount > 0 then
flaporan.qobat.Preview else
application.MessageBox('Tidak ada obat yang stoknya habis','Informasi!',mb_ok or mb_iconinformation);
end;


procedure Tfmenu.CBFilterChange(Sender: TObject);
begin
if CBFilter.ItemIndex=0 then
  Begin
  DTAwal.Format:='dd MMM yyy';
  DTAkhir.Visible:=True;
  end
else
if CBFilter.ItemIndex=1 then
  Begin
  DTAwal.Format:='MMMM yyyy';
  DTAkhir.Visible:=False;
  end
else
  Begin
  DTAwal.Format:='yyyy';
  DTAkhir.Visible:=False;
  end
end;

procedure Tfmenu.Button6Click(Sender: TObject);
begin
groupbox2.Visible := false;
end;

procedure Tfmenu.DTAwalChange(Sender: TObject);
begin
DTAkhir.Date:= EndOfTheMonth(DTAwal.Date);
end;

procedure Tfmenu.Button5Click(Sender: TObject);
begin
if CBFilter.ItemIndex=0 then
  Begin
    Sintak2:= 'select*from pembelian where '+
     ' tanggal>=#'+FormatDateTime('yyyy/MM/dd',DTAwal.Date)+'# and tanggal<=#'+FormatDateTime('yyyy/MM/dd',DTAkhir.Date)+'#';
     sql;
    if not dm.ADOQuery1.Eof then
      begin
        Sintak:= 'select * from pembelian,obat where pembelian.kode_obat=obat.kode_obat and tanggal>=#'+FormatDateTime('yyyy/MM/dd',DTAwal.Date)+'# and tanggal<=#'+FormatDateTime('yyyy/MM/dd',DTAkhir.Date)+'# order by tanggal';
        Sintak2:= 'select sum(tagihan) as total from pembelian where tanggal>=#'+FormatDateTime('yyyy/MM/dd',DTAwal.Date)+'# and tanggal<=#'+FormatDateTime('yyyy/MM/dd',DTAkhir.Date)+'# ';
        sql;
        flaporan.qrtotal.Caption := formatcurr('#,###',dm.ADOQuery1['total']);
        dm.ADOQuery1.Close;
        dm.ADOQuery1.SQL.Clear;
        dm.ADOQuery1.SQL.Text := sintak;
        dm.ADOQuery1.Open;
        flaporan.qtanggal.Caption := FormatDateTime('dd mmm yyyy',DTawal.Date)+' - '+FormatDateTime('dd mmm yyyy',DTakhir.Date) ;
        flaporan.qpembelian.Preview;
      end else application.MessageBox('Data tidak ditemukan','Informasi!',mb_ok or mb_iconinformation);
  end;
if CBFilter.ItemIndex=1 then
  Begin
    Sintak2:= 'select*from pembelian where '+
      ' month(tanggal)='+FormatDateTime('MM',DTAwal.Date)+' and year(tanggal)='+FormatDateTime('yyyy',DTAwal.Date)+'';
      sql;
    if not dm.ADOQuery1.Eof then
      begin
        Sintak:= 'select * from pembelian,obat where pembelian.kode_obat=obat.kode_obat and'+
          ' month(tanggal)='+FormatDateTime('MM',DTAwal.Date)+' and year(tanggal)='+FormatDateTime('yyyy',DTAwal.Date)+' order by tanggal';
        Sintak2:= 'select sum(tagihan) as total from pembelian where '+
          ' month(tanggal)='+FormatDateTime('MM',DTAwal.Date)+' and year(tanggal)='+FormatDateTime('yyyy',DTAwal.Date)+'';
        sql;
        flaporan.qrtotal.Caption := formatcurr('#,###',dm.ADOQuery1['total']);
        dm.ADOQuery1.Close;
        dm.ADOQuery1.SQL.Clear;
        dm.ADOQuery1.SQL.Text := sintak;
        dm.ADOQuery1.Open;
        flaporan.qtanggal.Caption := 'Bulan '+FormatDateTime('mmm yyyy',DTawal.Date);
        flaporan.qpembelian.Preview;
      end else application.MessageBox('Data tidak ditemukan','Informasi!',mb_ok or mb_iconinformation);
  end;
if CBFilter.ItemIndex=2 then
  Begin
    Sintak2:= 'select*from pembelian where year(tanggal)='+FormatDateTime('yyyy',DTAwal.Date)+'';
    sql;
    if not dm.ADOQuery1.Eof then
      begin
        Sintak:= 'select * from pembelian,obat where pembelian.kode_obat=obat.kode_obat'+
        ' and year(tanggal)='+FormatDateTime('yyyy',DTAwal.Date)+' order by tanggal';
        Sintak2:= 'select sum(tagihan) as total from pembelian where '+
        ' year(tanggal)='+FormatDateTime('yyyy',DTAwal.Date)+' ';
        sql;
        flaporan.qrtotal.Caption := formatcurr('#,###',dm.ADOQuery1['total']);
        dm.ADOQuery1.Close;
        dm.ADOQuery1.SQL.Clear;
        dm.ADOQuery1.SQL.Text := sintak;
        dm.ADOQuery1.Open;
        flaporan.qtanggal.Caption := 'Tahun '+FormatDateTime('yyyy',DTawal.Date);
        flaporan.qpembelian.Preview;
      end else application.MessageBox('Data tidak ditemukan','Informasi!',mb_ok or mb_iconinformation);
  end;
end;

procedure Tfmenu.Pembelian2Click(Sender: TObject);
begin
groupbox2.Visible := true;
end;

procedure Tfmenu.Penjualan2Click(Sender: TObject);
begin
groupbox3.Visible := true;
end;

procedure Tfmenu.ComboBox2Change(Sender: TObject);
begin
if ComboBox2.ItemIndex=0 then
  Begin
  tgl1.Format:='dd MMM yyy';
  tgl2.Visible:=True;
  end
else
if ComboBox2.ItemIndex=1 then
  Begin
  tgl1.Format:='MMMM yyyy';
  tgl2.Visible:=False;
  end
else
  Begin
  tgl1.Format:='yyyy';
  tgl2.Visible:=False;
  end
end;

procedure Tfmenu.tgl1Change(Sender: TObject);
begin
tgl2.Date:= EndOfTheMonth(tgl1.Date);
end;

procedure Tfmenu.Button8Click(Sender: TObject);
begin
groupbox3.Visible := false;
end;

procedure Tfmenu.Button7Click(Sender: TObject);
begin
if ComboBox2.ItemIndex=0 then
  Begin
    Sintak2:= 'select*from penjualan where '+
     ' tanggal>=#'+FormatDateTime('yyyy/MM/dd',tgl1.Date)+'# and tanggal<=#'+FormatDateTime('yyyy/MM/dd',tgl2.Date)+'#';
     sql;
    if not dm.ADOQuery1.Eof then
      begin
        Sintak:= 'select*from detail_penjualan,penjualan,obat where penjualan.no_nota=detail_penjualan.no_nota and obat.kode_obat=detail_penjualan.kode_obat and penjualan.tanggal>=#'+FormatDateTime('yyyy/MM/dd',tgl1.Date)+'# and penjualan.tanggal<=#'+FormatDateTime('yyyy/MM/dd',tgl2.Date)+'# order by detail_penjualan.no_nota';
        Sintak2:= 'select sum(tagihan) as total from penjualan where tanggal>=#'+FormatDateTime('yyyy/MM/dd',tgl1.Date)+'# and tanggal<=#'+FormatDateTime('yyyy/MM/dd',tgl2.Date)+'# ';
        sql;
        flaporan.qrtotal2.Caption := formatcurr('#,###',dm.ADOQuery1['total']);
        dm.ADOQuery1.Close;
        dm.ADOQuery1.SQL.Clear;
        dm.ADOQuery1.SQL.Text := sintak;
        dm.ADOQuery1.Open;
        flaporan.qrpenjualan.Caption := FormatDateTime('dd mmm yyyy',tgl1.Date)+' - '+FormatDateTime('dd mmm yyyy',tgl2.Date) ;
        flaporan.qpenjualan.Preview;
      end else application.MessageBox('Data tidak ditemukan','Informasi!',mb_ok or mb_iconinformation);
  end;
if ComboBox2.ItemIndex=1 then
  Begin
    Sintak2:= 'select*from penjualan where '+
      ' month(tanggal)='+FormatDateTime('MM',tgl1.Date)+' and year(tanggal)='+FormatDateTime('yyyy',tgl1.Date)+'';
      sql;
    if not dm.ADOQuery1.Eof then
      begin
        Sintak:= 'select*from penjualan,obat,detail_penjualan where detail_penjualan.no_nota=penjualan.no_nota and detail_penjualan.kode_obat=obat.kode_obat and'+
          ' month(penjualan.tanggal)='+FormatDateTime('MM',tgl1.Date)+' and year(penjualan.tanggal)='+FormatDateTime('yyyy',tgl1.Date)+' order by penjualan.no_nota';
        Sintak2:= 'select sum(tagihan) as total from penjualan where '+
          ' month(tanggal)='+FormatDateTime('MM',tgl1.Date)+' and year(tanggal)='+FormatDateTime('yyyy',tgl1.Date)+'';
        sql;
        flaporan.qrtotal2.Caption := formatcurr('#,###',dm.ADOQuery1['total']);
        dm.ADOQuery1.Close;
        dm.ADOQuery1.SQL.Clear;
        dm.ADOQuery1.SQL.Text := sintak;
        dm.ADOQuery1.Open;
        flaporan.qrpenjualan.Caption := 'Bulan '+FormatDateTime('mmm yyyy',tgl1.Date);
        flaporan.qpenjualan.Preview;
      end else application.MessageBox('Data tidak ditemukan','Informasi!',mb_ok or mb_iconinformation);
  end;
if ComboBox2.ItemIndex=2 then
  Begin
    Sintak2:= 'select*from penjualan where year(tanggal)='+FormatDateTime('yyyy',tgl1.Date)+'';
    sql;
    if not dm.ADOQuery1.Eof then
      begin
        Sintak:= 'select*from penjualan,obat,detail_penjualan where penjualan.no_nota=detail_penjualan.no_nota and obat.kode_obat=detail_penjualan.kode_obat and'+
        ' year(penjualan.tanggal)='+FormatDateTime('yyyy',tgl1.Date)+' order by penjualan.no_nota';
        Sintak2:= 'select sum(tagihan) as total from penjualan where '+
        ' year(tanggal)='+FormatDateTime('yyyy',tgl1.Date)+' ';
        sql;
        flaporan.qrtotal2.Caption := formatcurr('#,###',dm.ADOQuery1['total']);
        dm.ADOQuery1.Close;
        dm.ADOQuery1.SQL.Clear;
        dm.ADOQuery1.SQL.Text := sintak;
        dm.ADOQuery1.Open;
        flaporan.qrpenjualan.Caption := 'Tahun '+FormatDateTime('yyyy',tgl1.Date);
        flaporan.qpenjualan.Preview;
      end else application.MessageBox('Data tidak ditemukan','Informasi!',mb_ok or mb_iconinformation);
  end;
end;

procedure Tfmenu.Image6Click(Sender: TObject);
begin
fobat.Show;
hide;
end;

procedure Tfmenu.Image8Click(Sender: TObject);
begin
fpenjualan.Show;
hide;
end;

procedure Tfmenu.Image9Click(Sender: TObject);
begin
fpembelian.Show;
hide;
end;

procedure Tfmenu.Timer1Timer(Sender: TObject);
begin
ljam.Caption := formatdatetime('hh',now);
lmin.Caption := formatdatetime('nn',now);
ldet.Caption := formatdatetime('ss',now);
end;

procedure Tfmenu.Image7Click(Sender: TObject);
begin
fsupplier.Show;
hide;
end;

end.
