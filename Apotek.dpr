program Apotek;

uses
  Forms,
  ulogin in 'ulogin.pas' {flogin},
  umenu in 'umenu.pas' {fmenu},
  uobat in 'uobat.pas' {fobat},
  udm in 'udm.pas' {dm: TDataModule},
  upembelian in 'upembelian.pas' {fpembelian},
  upenjualan in 'upenjualan.pas' {fpenjualan},
  ulaporan in 'ulaporan.pas' {flaporan},
  usupplier in 'usupplier.pas' {fsupplier};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Aplikasi Kasir Apotek';
  Application.CreateForm(Tflogin, flogin);
  Application.CreateForm(Tfmenu, fmenu);
  Application.CreateForm(Tfpembelian, fpembelian);
  Application.CreateForm(Tfsupplier, fsupplier);
  Application.CreateForm(Tfpenjualan, fpenjualan);
  Application.CreateForm(Tfobat, fobat);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tflaporan, flaporan);
  Application.Run;
end.
