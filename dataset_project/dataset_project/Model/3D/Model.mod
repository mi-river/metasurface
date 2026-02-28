'# MWS Version: Version 2025.1 - Oct 28 2024 - ACIS 34.0.1 -

'# length = nm
'# frequency = PHz
'# time = fs
'# frequency range: fmin = 0.4 fmax = 0.75
'# created = '[VERSION]2025.1|34.0.1|20241028[/VERSION]


'@ use template: FSS, Metamaterial - Unit Cell_3.cfg

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
'set the units
With Units
    .SetUnit "Length", "nm"
    .SetUnit "Frequency", "PHz"
    .SetUnit "Voltage", "V"
    .SetUnit "Resistance", "Ohm"
    .SetUnit "Inductance", "nH"
    .SetUnit "Temperature",  "K"
    .SetUnit "Time", "fs"
    .SetUnit "Current", "A"
    .SetUnit "Conductance", "S"
    .SetUnit "Capacitance", "pF"
End With

'----------------------------------------------------------------------------

'set the frequency range
Solver.FrequencyRange "0.4", "0.75"

'----------------------------------------------------------------------------

Plot.DrawBox True

With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .Rho "1.204"
     .ThermalType "Normal"
     .ThermalConductivity "0.026"
      .SpecificHeat "1005", "J/K/kg"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With

' define Floquet port boundaries

With FloquetPort
     .Reset
     .SetDialogTheta "0"
     .SetDialogPhi "0"
     .SetSortCode "+beta/pw"
     .SetCustomizedListFlag "False"
     .Port "Zmin"
     .SetNumberOfModesConsidered "2"
     .Port "Zmax"
     .SetNumberOfModesConsidered "2"
End With

MakeSureParameterExists "theta", "0"
SetParameterDescription "theta", "spherical angle of incident plane wave"
MakeSureParameterExists "phi", "0"
SetParameterDescription "phi", "spherical angle of incident plane wave"

' define boundaries, the open boundaries define floquet port

With Boundary
     .Xmin "unit cell"
     .Xmax "unit cell"
     .Ymin "unit cell"
     .Ymax "unit cell"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0.0"
     .PeriodicUseConstantAngles "False"
     .SetPeriodicBoundaryAngles "theta", "phi"
     .SetPeriodicBoundaryAnglesDirection "inward"
     .UnitCellFitToBoundingBox "True"
     .UnitCellDs1 "0.0"
     .UnitCellDs2 "0.0"
     .UnitCellAngle "90.0"
End With

' set tet mesh as default

With Mesh
     .MeshType "Tetrahedral"
End With

' FD solver excitation with incoming plane wave at Zmax

With FDSolver
     .Reset
     .Stimulation "List", "List"
     .ResetExcitationList
     .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)"
     .LowFrequencyStabilization "False"
End With

'----------------------------------------------------------------------------

Dim sDefineAt As String
sDefineAt = "0.4;0.575;0.75"
Dim sDefineAtName As String
sDefineAtName = "0.4;0.575;0.75"
Dim sDefineAtToken As String
sDefineAtToken = "f="
Dim aFreq() As String
aFreq = Split(sDefineAt, ";")
Dim aNames() As String
aNames = Split(sDefineAtName, ";")

Dim nIndex As Integer
For nIndex = LBound(aFreq) To UBound(aFreq)

Dim zz_val As String
zz_val = aFreq (nIndex)
Dim zz_name As String
zz_name = sDefineAtToken & aNames (nIndex)

' Define E-Field Monitors
With Monitor
    .Reset
    .Name "e-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Efield"
    .MonitorValue  zz_val
    .Create
End With

' Define Power flow Monitors
With Monitor
    .Reset
    .Name "power ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerflow"
    .MonitorValue  zz_val
    .Create
End With

Next

'----------------------------------------------------------------------------

With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 1%
End With

With Mesh
     .MeshType "Tetrahedral"
End With

'set the solver type
ChangeSolverType("HF Frequency Domain")

'----------------------------------------------------------------------------

'@ define material: SiO2

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
With Material 
     .Reset 
     .Name "SiO2"
     .Folder ""
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .SolarRadiationAbsorptionType "Opaque"
     .Absorptance "0.0"
     .UseSemiTransparencyCalculator "False"
     .SolarRadTransmittance "0.0"
     .SolarRadReflectance "0.0"
     .SolarRadSpecimenThickness "0.0"
     .SolarRadRefractiveIndex "1.0"
     .SolarRadAbsorptionCoefficient "0.0"
     .IntrinsicCarrierDensityModel "none"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "PHz"
     .MaterialUnit "Geometry", "nm"
     .MaterialUnit "Time", "fs"
     .MaterialUnit "Temperature", "K"
     .Epsilon "1"
     .Mu "1"
     .Sigma "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.000061"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .DispersiveFittingFormatEps "Real_Imag"
     .AddDispersionFittingValueEps "0.04474514", "1.34478676", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.04632146", "1.43358876", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.04795145", "1.50820219", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.04964273", "1.57183630", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.05139593", "1.62657475", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.05320186", "1.67377878", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.05507853", "1.71515274", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.05701644", "1.75141547", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.05902588", "1.78351313", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.06110731", "1.81203131", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.0632607", "1.83745133", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.06548546", "1.86017257", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.06779567", "1.88065603", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.07019257", "1.89915899", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.07265935", "1.91579041", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.07521135", "1.93086405", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.07786817", "1.94464021", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.08061104", "1.95715064", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.08346115", "1.96860794", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.08639552", "1.97902495", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.08943689", "1.98857854", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.09258569", "1.99734384", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.09584158", "2.00538819", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.09923617", "2.01284008", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.10273902", "2.01967987", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.10634709", "2.02595759", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.11009639", "2.03177780", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.11398953", "2.03717414", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.11798208", "2.04212311", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.12216482", "2.04676428", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.12644136", "2.05101699", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.13091374", "2.05500792", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.13553004", "2.05870734", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.1402866", "2.06213610", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.14524828", "2.06535689", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.15034727", "2.06834141", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.15565548", "2.07114716", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.16109213", "2.07374671", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.16682941", "2.07623133", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.17269151", "2.07853399", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.17876712", "2.08070405", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.18505707", "2.08275099", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.19156068", "2.08468377", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.19827544", "2.08651088", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.2053373", "2.08827397", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.21261876", "2.08994607", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.22011194", "2.09153451", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.22780582", "2.09304607", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.23587133", "2.09451976", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.24413067", "2.09592866", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.2527761", "2.09731122", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.261599", "2.09863987", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.27081523", "2.09995301", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.28044196", "2.10125635", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.29021535", "2.10252019", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.30051369", "2.10379863", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.31111712", "2.10506844", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.32208042", "2.10634158", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.33339909", "2.10762273", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.34514444", "2.10892498", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.35732117", "2.11025383", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.36993146", "2.11161473", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.38292561", "2.11300777", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.39644599", "2.11445382", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.41039351", "2.11594807", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.42487593", "2.11750817", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.43983635", "2.11913440", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.45533484", "2.12084000", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.47137179", "2.12263221", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.48802288", "2.12452723", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.50521142", "2.12652453", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.52301545", "2.12864179", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.54143482", "2.13088841", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.56046449", "2.13327372", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.58020603", "2.13582146", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.60066612", "2.13854485", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.62184704", "2.14145742", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.64374588", "2.14457289", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.66650169", "2.14792717", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.68997113", "2.15151638", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.71430178", "2.15538168", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.73931556", "2.15951445", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.76536242", "2.16399549", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.79247279", "2.16885907", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.8202256", "2.17405671", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.84927042", "2.17974258", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.87915677", "2.18586660", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.91011675", "2.19251526", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.94215103", "2.19973521", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.97525198", "2.20757619", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.0097422", "2.21617791", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.04530146", "2.22553140", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.08228324", "2.23581060", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.12030067", "2.24699866", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.15973872", "2.25931250", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.20061056", "2.27288667", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.24292064", "2.28787440", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.28666291", "2.30445081", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.331819", "2.32281652", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.37899015", "2.34349080", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "1.42758313", "2.36654417", "0.00000000", "1.0"
     .UseGeneralDispersionEps "True"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define material: TiO2

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
With Material 
     .Reset 
     .Name "TiO2"
     .Folder ""
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .SolarRadiationAbsorptionType "Opaque"
     .Absorptance "0.0"
     .UseSemiTransparencyCalculator "False"
     .SolarRadTransmittance "0.0"
     .SolarRadReflectance "0.0"
     .SolarRadSpecimenThickness "0.0"
     .SolarRadRefractiveIndex "1.0"
     .SolarRadAbsorptionCoefficient "0.0"
     .IntrinsicCarrierDensityModel "none"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "PHz"
     .MaterialUnit "Geometry", "nm"
     .MaterialUnit "Time", "fs"
     .MaterialUnit "Temperature", "K"
     .Epsilon "1"
     .Mu "1"
     .Sigma "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.000003"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .DispersiveFittingFormatEps "Real_Imag"
     .AddDispersionFittingValueEps "0.19594278", "6.02098018", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.19736172", "6.02260634", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.19880136", "6.02426995", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.20026216", "6.02597218", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.20174459", "6.02771425", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.20324912", "6.02949744", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.20477627", "6.03132306", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.20632654", "6.03319249", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.20790046", "6.03510715", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.20949857", "6.03706853", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.21112145", "6.03907820", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.21276967", "6.04113776", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.21444382", "6.04324891", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.21614453", "6.04541340", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.21787243", "6.04763308", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.21962817", "6.04990985", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.22141245", "6.05224573", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.22322596", "6.05464281", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.22506941", "6.05710328", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.22694357", "6.05962942", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.2288492", "6.06222362", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.23078711", "6.06488840", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.23275812", "6.06762638", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.23476308", "6.07044030", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.23680289", "6.07333304", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.23887845", "6.07630763", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.24099072", "6.07936724", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.24314068", "6.08251518", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.24532934", "6.08575496", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.24755777", "6.08909025", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.24982705", "6.09252490", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.25213832", "6.09606296", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.25449275", "6.09970873", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.25689157", "6.10346668", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.25933604", "6.10734156", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.26182747", "6.11133838", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.26436725", "6.11546239", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.26695677", "6.11971918", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.26959753", "6.12411461", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.27229106", "6.12865490", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.27503895", "6.13334663", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.27784287", "6.13819676", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.28070455", "6.14321265", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.28362579", "6.14840213", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.28660847", "6.15377347", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.28965455", "6.15933549", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.29276607", "6.16509754", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.29594517", "6.17106956", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.29919407", "6.17726214", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.30251509", "6.18368656", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.30591067", "6.19035485", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.30938334", "6.19727983", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.31293576", "6.20447522", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.31657071", "6.21195568", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.32029109", "6.21973690", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.32409995", "6.22783571", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.3280005", "6.23627015", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.33199608", "6.24505960", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.3360902", "6.25422489", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.34028656", "6.26378845", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.34458903", "6.27377446", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.3490017", "6.28420902", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.35352884", "6.29512034", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.35817498", "6.30653893", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.36294486", "6.31849789", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.36784351", "6.33103314", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.37287619", "6.34418371", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.3780485", "6.35799215", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.38336631", "6.37250484", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.38883587", "6.38777248", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.39446376", "6.40385059", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.40025695", "6.42080007", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.40622284", "6.43868785", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.41236927", "6.45758770", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.41870455", "6.47758104", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.42523753", "6.49875799", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.43197761", "6.52121855", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.43893478", "6.54507393", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.44611973", "6.57044821", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.45354381", "6.59748016", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.46121917", "6.62632554", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.46915878", "6.65715967", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.47737653", "6.69018063", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.48588729", "6.72561298", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.49470703", "6.76371235", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.50385287", "6.80477094", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.51334325", "6.84912419", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.52319801", "6.89715911", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.53343854", "6.94932442", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.54408795", "7.00614334", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.55517122", "7.06822953", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.56671542", "7.13630749", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.57874992", "7.21123852", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.59130662", "7.29405449", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.60442028", "7.38600200", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.61812878", "7.48860110", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.63247354", "7.60372422", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.64749991", "7.73370426", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.66325765", "7.88148489", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.67980149", "8.05083379", "0.00000000", "1.0"
     .AddDispersionFittingValueEps "0.69719176", "8.24665201", "0.00000000", "1.0"
     .UseGeneralDispersionEps "True"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define material colour: SiO2

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
With Material 
     .Name "SiO2"
     .Folder ""
     .Colour "1", "0", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ define material colour: TiO2

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
With Material 
     .Name "TiO2"
     .Folder ""
     .Colour "0", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ new component: component1

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
Component.New "component1"

'@ define brick: component1:sub

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
With Brick
     .Reset 
     .Name "sub" 
     .Component "component1" 
     .Material "SiO2" 
     .Xrange "-P/2", "P/2" 
     .Yrange "-P/2", "P/2" 
     .Zrange "-H_sub", "0" 
     .Create
End With

'@ define brick: component1:pillar

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
With Brick
     .Reset 
     .Name "pillar" 
     .Component "component1" 
     .Material "TiO2" 
     .Xrange "-L/2", "L/2" 
     .Yrange "-W/2", "W/2" 
     .Zrange "0", "H" 
     .Create
End With

'@ define frequency domain solver parameters

'[VERSION]2025.1|34.0.1|20241028[/VERSION]
Mesh.SetCreator "High Frequency" 

With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "Zmax", "All" 
     .ResetExcitationList 
     .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)" 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "False" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-4" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "False" 
     .Type "Auto" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
     .SetOpenBCTypeHex "Default" 
     .SetOpenBCTypeTet "Default" 
     .AddMonitorSamples "True" 
     .CalcPowerLoss "True" 
     .CalcPowerLossPerComponent "False" 
     .SetKeepSolutionCoefficients "MonitorsAndMeshAdaptation" 
     .UseDoublePrecision "False" 
     .UseDoublePrecision_ML "True" 
     .MixedOrderSrf "False" 
     .MixedOrderTet "False" 
     .PreconditionerAccuracyIntEq "0.15" 
     .MLFMMAccuracy "Default" 
     .MinMLFMMBoxSize "0.3" 
     .UseCFIEForCPECIntEq "True" 
     .UseEnhancedCFIE2 "True" 
     .UseFastRCSSweepIntEq "false" 
     .UseSensitivityAnalysis "False" 
     .UseEnhancedNFSImprint "True" 
     .UseFastDirectFFCalc "True" 
     .RemoveAllStopCriteria "Hex"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
     .RemoveAllStopCriteria "Tet"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
     .RemoveAllStopCriteria "Srf"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
     .SweepMinimumSamples "3" 
     .SetNumberOfResultDataSamples "1001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddSampleInterval "", "", "", "Automatic", "False" 
     .MPIParallelization "False"
     .UseDistributedComputing "False"
     .NetworkComputingStrategy "RunRemote"
     .NetworkComputingJobCount "3"
     .UseParallelization "True"
     .MaxCPUs "1024"
     .MaximumNumberOfCPUDevices "2"
     .HardwareAcceleration "False"
     .MaximumNumberOfGPUs "1"
End With

With IESolver
     .Reset 
     .UseFastFrequencySweep "True" 
     .UseIEGroundPlane "False" 
     .SetRealGroundMaterialName "" 
     .CalcFarFieldInRealGround "False" 
     .RealGroundModelType "Auto" 
     .PreconditionerType "Auto" 
     .ExtendThinWireModelByWireNubs "False" 
     .ExtraPreconditioning "False" 
End With

With IESolver
     .SetFMMFFCalcStopLevel "0" 
     .SetFMMFFCalcNumInterpPoints "6" 
     .UseFMMFarfieldCalc "True" 
     .SetCFIEAlpha "0.500000" 
     .LowFrequencyStabilization "False" 
     .LowFrequencyStabilizationML "True" 
     .Multilayer "False" 
     .SetiMoMACC_I "0.0001" 
     .SetiMoMACC_M "0.0001" 
     .DeembedExternalPorts "True" 
     .SetOpenBC_XY "True" 
     .OldRCSSweepDefintion "False" 
     .SetRCSOptimizationProperties "True", "100", "0.00001" 
     .SetAccuracySetting "Medium" 
     .CalculateSParaforFieldsources "True" 
     .ModeTrackingCMA "True" 
     .NumberOfModesCMA "3" 
     .StartFrequencyCMA "-1.0" 
     .SetAccuracySettingCMA "Default" 
     .FrequencySamplesCMA "0" 
     .SetMemSettingCMA "Auto" 
     .CalculateModalWeightingCoefficientsCMA "True" 
     .DetectThinDielectrics "True" 
     .UseLegacyRadiatedPowerCalc "False" 
End With

