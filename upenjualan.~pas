unit upenjualan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, ComCtrls, jpeg;

type
  Tfpenjualan = class(TForm)
    DBGrid1: TDBGrid;
    Image1: TImage;
    Edit7: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lnota: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    lnama: TLabel;
    lkode: TLabel;
    Label6: TLabel;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Button1: TButton;
    DBGrid2: TDBGrid;
    Edit3: TEdit;
    ltagihan: TLabel;
    lsisa: TLabel;
    Button2: TButton;
    Button3: TButton;
    procedure nota;
    procedure awal;
    procedure detail;
    procedure cetaknota;
    procedure obat;
    procedure Edit7Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fpenjualan: Tfpenjualan;
  stok1,stok2,total,tagihan,harga, totaltagihan : real;
  bulatin : integer;
  sRupiah: string;
  iRupiah: Currency;

implementation

uses udm, umenu, U_Cetak;

{$R *.dfm}

procedure Tfpenjualan.awal;
begin
edit1.Clear;
lkode.Caption := '_________';
lnama.Caption := '_________';
edit3.Clear;
edit3.Enabled := false;
edit2.Enabled := false;
button1.Enabled := false;
button2.Enabled := false;
edit7.Clear;
ltagihan.Caption := '0';
lsisa.Caption := '0';
edit1.SetFocus;
end;

procedure Tfpenjualan.cetaknota;
const Enter = #13 + #10;
var
txtFile: TextFile;
nmfile,nama,alamat,no : string;
subtotal,total,pcs : real;
begin
total := 0;  pcs := 0;
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from konfigurasi where id_konfigurasi =1';
dm.ADOQuery1.Open;
nama := dm.ADOQuery1['nama_apotek'];
alamat := dm.ADOQuery1['alamat'];
no := dm.ADOQuery1['no'];
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from detail_penjualan,obat where detail_penjualan.no_nota ='+quotedstr(lnota.Caption)+' and detail_penjualan.kode_obat = obat.kode_obat ';
dm.ADOQuery1.Open;
  // File Struk.txt
        nmfile := GetCurrentDir + '\struk.txt';
        AssignFile(txtFile, nmfile);
        Rewrite(txtFile);
        WriteLn(txtFile, '================================');
        WriteLn(txtFile, nama);
        WriteLn(txtFile, alamat);
        WriteLn(txtFile, 'No. Telp '+no);
        WriteLn(txtFile, '================================');
        WriteLn(txtFile, 'No. Nota  : ' + lnota.caption );
        WriteLn(txtFile, 'Tanggal   : ' + FormatDateTime('dd-mm-yyyy hh:mm', now));
        WriteLn(txtFile, 'Pelanggan : ' + edit1.Text);
        WriteLn(txtFile, '================================');
        while Not dm.ADOQuery1.Eof do
        begin
          WriteLn(txtFile, dm.ADOQuery1['nama']);
          subtotal := dm.ADOQuery1['harga_jual']*dm.ADOQuery1['jumlah'];
          pcs      := pcs+dm.ADOQuery1['jumlah'];
          total    := total+dm.ADOQuery1['harga_jual']*dm.ADOQuery1['jumlah'];
          WriteLn(txtFile, RataKanan(floattostr(dm.ADOQuery1['jumlah'])+' PCS  Rp.'+formatcurr('#,###',dm.ADOQuery1['harga_jual'])+'   ', 'Rp. '+formatcurr('#,###',subtotal), 23, ' '));
        dm.ADOQuery1.Next;
        end;
        WriteLn(txtFile, '================================');
        WriteLn(txtFile, RataKanan('Total      : ', 'Rp. '+formatcurr('#,###',total), 20,' '));
        WriteLn(txtFile, RataKanan('Bayar      : ', 'Rp. '+formatcurr('#,###',strtofloat(edit3.Text)), 20,' '));
        WriteLn(txtFile, RataKanan('Kembali    : ', 'Rp. '+formatcurr('#,###',strtofloat(edit3.Text)-total), 20,' '));
        WriteLn(txtFile, '================================');
        WriteLn(txtFile, 'Jumlah Item : '+floattostr(pcs)+' PCS');
        WriteLn(txtFile, '================================');
        WriteLn(txtFile, '      --- TERIMA KASIH --- ');
        WriteLn(txtFile, '================================');
        WriteLn(txtFile, Enter + Enter + Enter + Enter + Enter + Enter + Enter + Enter + Enter + Enter );
         CloseFile(txtFile);
         // Cetak File Struk.txt
         cetakFile('struk.txt');
end;

procedure Tfpenjualan.detail;
begin
dm.ADOdetail.Close;
dm.ADOdetail.SQL.Clear;
dm.ADOdetail.SQL.Text := 'select*from detail_penjualan,obat where detail_penjualan.no_nota ='+quotedstr(lnota.Caption)+' and detail_penjualan.kode_obat = obat.kode_obat ';
dm.ADOdetail.Open;
end;

procedure Tfpenjualan.Edit7Change(Sender: TObject);
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat like '+quotedstr('%'+edit7.Text+'%')+' or nama like '+quotedstr('%'+edit7.Text+'%')+'';
dm.ADOQuery1.Open;
end;

procedure Tfpenjualan.nota;
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from penjualan';
dm.ADOQuery1.Open;
lnota.Caption := formatdatetime('yymmdd',now)+''+inttostr(dm.ADOQuery1.RecordCount+1);
end;

procedure Tfpenjualan.obat;
begin
dm.ADOQuery1.Close;
dm.ADOQuery1.SQL.Clear;
dm.ADOQuery1.SQL.Text := 'select*from obat where stok > 0';
dm.ADOQuery1.Open;
end;

procedure Tfpenjualan.FormShow(Sender: TObject);
begin
awal;
nota;
obat;
detail;
end;

procedure Tfpenjualan.Button3Click(Sender: TObject);
begin
hide;
fmenu.show;
end;

procedure Tfpenjualan.DBGrid1DblClick(Sender: TObject);
begin
lkode.Caption := dm.ADOQuery1['kode_obat'];
lnama.Caption := dm.ADOQuery1['nama'];
stok1 :=  dm.ADOQuery1['stok'];
harga :=  dm.ADOQuery1['harga_jual'];
edit2.Enabled := true;
edit2.SetFocus;
button1.Enabled := true;
updown1.Enabled := true;
end;

procedure Tfpenjualan.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then button1.Click;
if (key in['a'..'z','A'..'Z',#32]) then
  begin
    key:=#0;
    application.MessageBox('Input data harus berisi angka!','Informasi!',mb_ok or mb_iconinformation);
  end;
end;

procedure Tfpenjualan.Button1Click(Sender: TObject);
var count: integer;
begin
dm.ADOdetail.Close;
dm.ADOdetail.SQL.Clear;
dm.ADOdetail.SQL.Text := 'select*from detail_penjualan where no_nota ='+quotedstr(lnota.Caption)+' and kode_obat ='+quotedstr(lkode.Caption)+'';
dm.ADOdetail.Open;
count := dm.ADOdetail.RecordCount;
detail;
stok2 := strtofloat(edit2.Text);
if edit2.Text = '0' then
begin
application.MessageBox('Jumlah obat yang akan dibeli belum ada','Informasi!',mb_ok or mb_iconinformation);
edit2.SetFocus;
end
else if stok2>stok1 then
application.MessageBox('Jumlah stok obat tidak mencukupi','Informasi!',mb_ok or mb_iconinformation)
else if count>0 then
application.MessageBox('Obat yang tambahkan sudah dimasukan sebelumnya','Informasi!',mb_ok or mb_iconinformation) else
 begin
  dm.ADOdetail.Close;
  dm.ADOdetail.SQL.Clear;
  dm.ADOdetail.SQL.Text := 'select*from detail_penjualan ';
  dm.ADOdetail.Open;
  dm.ADOdetail.Append;
  dm.ADOdetail['no_nota'] := lnota.Caption;
  dm.ADOdetail['kode_obat'] := lkode.Caption;
  dm.ADOdetail['jumlah'] := edit2.Text;
  dm.ADOdetail['total'] := strtofloat(edit2.Text)*harga;
  dm.ADOdetail.Post;


  dm.ADOQuery1.Close;
  dm.ADOQuery1.SQL.Clear;
  dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat ='+quotedstr(lkode.Caption)+'';
  dm.ADOQuery1.Open;
  dm.ADOQuery1.Edit;
  dm.ADOQuery1['stok'] := floattostr(stok1-stok2);
  dm.ADOQuery1.Post;

  dm.ADOdetail.Close;
  dm.ADOdetail.SQL.Clear;
  dm.ADOdetail.SQL.Text := 'select sum(detail_penjualan.jumlah*obat.harga_jual) as total from detail_penjualan, obat where detail_penjualan.no_nota ='+quotedstr(lnota.Caption)+' and detail_penjualan.kode_obat = obat.kode_obat';
  dm.ADOdetail.Open;

  tagihan := dm.ADOdetail['total'];
  lkode.Caption := '_____';
  lnama.Caption := '_____';
  ltagihan.Caption := 'Rp. '+formatcurr('#,###',tagihan);
  edit2.Text := '0';
  edit2.Enabled := false;
  detail;
  obat;
  button1.Enabled := false;
  button2.Enabled := true;
  button3.Enabled := false;
  edit3.Enabled := true;
 end
end;

procedure Tfpenjualan.DBGrid2DblClick(Sender: TObject);
var count:integer;
begin
count :=  dm.ADOdetail.RecordCount;
if count = 0 then
application.MessageBox('Tidak ada pesanan yang dibatalkan','Informasi!',mb_ok or mb_iconinformation)  else
begin
  dm.ADOQuery1.Close;
  dm.ADOQuery1.SQL.Clear;
  dm.ADOQuery1.SQL.Text := 'select*from obat where kode_obat ='+quotedstr(dm.ADOdetail['obat.kode_obat'])+'';
  dm.ADOQuery1.Open;
  dm.ADOQuery1.Edit;
  dm.ADOQuery1['stok'] := floattostr(dm.ADOQuery1['stok']+dm.ADOdetail['jumlah']);
  dm.ADOQuery1.Post;

  dm.ADOQuery1.Close;
  dm.ADOQuery1.SQL.Clear;
  dm.ADOQuery1.SQL.Text := 'delete*from detail_penjualan where no_nota ='+quotedstr(lnota.Caption)+' and kode_obat ='+quotedstr(dm.ADOdetail['obat.kode_obat'])+'';
  dm.ADOQuery1.ExecSQL;
  dm.ADOQuery1.SQL.Text := 'select*from detail_penjualan';
  dm.ADOQuery1.Open;
  
  dm.ADOdetail.Close;
  dm.ADOdetail.SQL.Clear;
  dm.ADOdetail.SQL.Text := 'select sum(detail_penjualan.jumlah*obat.harga_jual) as total from detail_penjualan, obat where detail_penjualan.no_nota ='+quotedstr(lnota.Caption)+' and detail_penjualan.kode_obat = obat.kode_obat';
  dm.ADOdetail.Open;

  detail;
  if dm.ADOdetail.RecordCount = 0 then
  begin
  ltagihan.Caption := '0';
  button2.Enabled := false;
  button3.Enabled := true;
  edit3.Enabled := false;
  end else
  begin
  ltagihan.Caption := 'Rp. '+formatcurr('#,###',tagihan);
  tagihan :=  dm.ADOdetail['total'];
  edit3.Enabled := true;
  end;
  obat;
  detail;
  application.MessageBox('Pesanan obat telah dibatalkan','Informasi!',mb_ok or mb_iconinformation);
end;
end;

procedure Tfpenjualan.Button2Click(Sender: TObject);
begin
if edit1.Text = '' then
begin
  application.MessageBox('Nama pelanggan belum diisi','Informasi!',mb_ok or mb_iconinformation);
  edit1.SetFocus;
end else
if edit3.Text = '' then
begin
  application.MessageBox('Nominal tagihan pembayaran belum diisi','Informasi!',mb_ok or mb_iconinformation);
  edit3.SetFocus;
end else
if strtofloat(edit3.Text)<tagihan then
begin
  application.MessageBox('Nominal tagihan pembayaran kurang','Informasi!',mb_ok or mb_iconinformation);
  edit3.SetFocus;
end else
begin
  cetaknota;
  dm.ADOQuery1.Close;
  dm.ADOQuery1.SQL.Clear;
  dm.ADOQuery1.SQL.Text := 'select*from penjualan';
  dm.ADOQuery1.Open;
  dm.ADOQuery1.Append;
  dm.ADOQuery1['no_nota'] := lnota.Caption;
  dm.ADOQuery1['nama_pelanggan'] := edit1.Text;
  dm.ADOQuery1['tagihan'] := tagihan;
  dm.ADOQuery1['tanggal'] := FormatDateTime('dd/mm/yyyy', now);
  dm.ADOQuery1.Post;
  awal;
  nota;
  obat;
  detail;
  application.MessageBox('Transaksi penjualan berhasil','Informasi!',mb_ok or mb_iconinformation);
  button3.Enabled := true;
end
end;

procedure Tfpenjualan.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if (key in['a'..'z','A'..'Z',#32]) then
  begin
    key:=#0;
    application.MessageBox('Input data harus berisi angka!','Informasi!',mb_ok or mb_iconinformation);
  end;
end;

procedure Tfpenjualan.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
srupiah := edit3.Text;
srupiah := Stringreplace(sRupiah,',','',[rfreplaceall,rfignorecase]);
srupiah := Stringreplace(sRupiah,'.','',[rfreplaceall,rfignorecase]);
irupiah := StrToCurrDef(srupiah,0);
totaltagihan := irupiah;
edit3.Text := formatcurr('#,###',irupiah);
edit3.SelStart :=  length(edit7.Text);
end;

procedure Tfpenjualan.Edit3Change(Sender: TObject);
var a,b,c : real;
begin
if (edit3.Text <> '') then
a := strtofloat(edit3.Text);
b := a-tagihan;

if b<0 then
lsisa.Caption := 'Rp. 0' else
lsisa.Caption := 'Rp. '+formatcurr('#,###',b);
end;

end.
