function cstExportSpTxt(mws, str, exportPath)

selectTreeItem = invoke(mws,'SelectTreeItem',['1D Results\S-Parameters\',str]);

plot1D = invoke(mws, 'Plot1D');
invoke(plot1D, 'PlotView', 'magnitudedb');% Export dB value

asciiExport = invoke(mws,'ASCIIExport');
invoke(asciiExport,'Reset');
invoke(asciiExport,'SetVersion','2010');
invoke(asciiExport,'FileName',[exportPath(1:end-4),'_Am','.txt']);
invoke(asciiExport,'Execute');


invoke(plot1D, 'PlotView', 'phase');
asciiExport = invoke(mws,'ASCIIExport');
invoke(asciiExport,'Reset');
invoke(asciiExport,'SetVersion','2010');
invoke(asciiExport,'FileName',[exportPath(1:end-4),'_Ph','.txt']);
invoke(asciiExport,'Execute');