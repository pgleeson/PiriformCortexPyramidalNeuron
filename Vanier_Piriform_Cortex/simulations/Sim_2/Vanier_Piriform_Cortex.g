//  ******************************************************
// 
//     File generated by: neuroConstruct v1.6.1
// 
//  ******************************************************

echo ""
echo "*****************************************************"
echo ""
echo "    neuroConstruct generated GENESIS simulation"
echo "    for project: /home/Simon/nC_projects/Vanier_Piriform_Cortex/Vanier_Piriform_Cortex.ncx"
echo ""
echo "    Description: "

echo "    Simulation configuration: Default Simulation Configuration"
echo "    Simulation reference: Sim_2"
echo " "
echo  "*****************************************************"



//   Initializes random-number generator

randseed 1242053636

//   This temperature is needed if any of the channels are temp dependent (Q10 dependence) 
//   

float celsius = 6.3

str units = "GENESIS SI Units"

str genesisCore = "GENESIS2"


//   Including neuroConstruct utilities file

include nCtools 

//   Including external files

include compartments 

//   Creating element for channel prototypes

if (!{exists /library})
    create neutral /library
end

disable /library
pushe /library
make_cylind_compartment
make_cylind_symcompartment
pope

env // prints details on some global variables



//   Including channel mechanisms 
//   

include Na_Hipo_original
make_Na_Hipo_original

include LeakConductance
make_LeakConductance


//   Including synaptic mech 
//   



create neutral /cells

//////////////////////////////////////////////////////////////////////
//   Cell group 0: CellGroup_2 has cells of type: Pyramidal_Neuron_original_soma
//////////////////////////////////////////////////////////////////////


create neutral /cells/CellGroup_2
//   Adding cells of type Pyramidal_Neuron_original_soma in region Regions_1

//   Placing these cells in a region described by: Rectangular Box from point: (0.0, 0.0, 0.0) to (120.0, 50.0, 120.0)

//   Packing has been generated by: Random: num: 1, edge: 1, overlap: 1, other overlap: 1


str compName

readcell /home/Simon/nC_projects/Vanier_Piriform_Cortex/simulations/Sim_2/Pyramidal_Neuron_original_soma.p /cells/CellGroup_2/CellGroup_2_0
addfield /cells/CellGroup_2/CellGroup_2_0 celltype
setfield /cells/CellGroup_2/CellGroup_2_0 celltype Pyramidal_Neuron_original_soma

position /cells/CellGroup_2/CellGroup_2_0 1.063754E-4 5.59139E-6 1.027085E-4



//////////////////////////////////////////////////////////////////////
//   Adding 1 stimulation(s)
//////////////////////////////////////////////////////////////////////

create neutral /stim
create neutral /stim/pulse
create neutral /stim/rndspike
create pulsegen /stim/pulse/stim_Input_1_CellGroup_2_0

//   Adding a current pulse of amplitude: 1.0E-9 A, SingleElectricalInput: [Input: IClamp, cellGroup: CellGroup_2, cellNumber: 0, segmentId: 0, fractionAlong: 0.5]

//   Pulses are shifted one dt step, so that pulse will begin at delay1, as in NEURON

setfield ^ level1 1.0E-9 width1 5.0E-4 delay1 0.019975 delay2 10000.0  
addmsg /stim/pulse/stim_Input_1_CellGroup_2_0 /cells/CellGroup_2/CellGroup_2_0/Soma INJECT output


//////////////////////////////////////////////////////////////////////
//   Crank-Nicholson num integration method (11), using hsolve: true, chanmode: 0
//////////////////////////////////////////////////////////////////////

echo "----------- Specifying hsolve"

str cellName
foreach cellName ({el /cells/#/#})
    create hsolve {cellName}/solve
    setfield {cellName}/solve path {cellName}/#[][TYPE=compartment],{cellName}/#[][TYPE=symcompartment] comptmode 1
    setmethod {cellName}/solve 11
    setfield {cellName}/solve chanmode 0
    call {cellName}/solve SETUP
    reset
end
reset
echo "-----------Done specifying hsolve "


//////////////////////////////////////////////////////////////////////
//   Settings for running the demo
//////////////////////////////////////////////////////////////////////


float dt = 2.5E-5
float duration = 0.1
int steps =  {round {{duration}/{dt}}}

setclock 0 {dt} // Units[GENESIS_SI_time, symbol: s]

//////////////////////////////////////////////////////////////////////
//   Adding 1 plot(s)
//////////////////////////////////////////////////////////////////////

create neutral /plots


create xform /plots/CellGroup_2_v [500,100,400,400]  -title "Values of VOLTAGE (Vm) in /cells/CellGroup_2/CellGroup_2_0: Sim_2"
xshow /plots/CellGroup_2_v
create xgraph /plots/CellGroup_2_v/graph -xmin 0 -xmax {duration} -ymin -0.09 -ymax 0.05
addmsg /cells/CellGroup_2/CellGroup_2_0/Soma /plots/CellGroup_2_v/graph PLOT Vm *...p_2/CellGroup_2_0_Soma:Vm *black


//////////////////////////////////////////////////////////////////////
//   Creating a simple Run Control
//////////////////////////////////////////////////////////////////////

if (!{exists /controls})
    create neutral /controls
end
create xform /controls/runControl [700, 20, 200, 140] -title "Run Controls: Sim_2"
xshow /controls/runControl

create xbutton /controls/runControl/RESET -script reset
str rerun
rerun = { strcat "step " {steps} }
create xbutton /controls/runControl/RUN -script {rerun}
create xbutton /controls/runControl/STOP -script stop

create xbutton /controls/runControl/QUIT -script quit


echo Checking and resetting...

maxwarnings 400

//////////////////////////////////////////////////////////////////////
//   Recording 1 variable(s)
//////////////////////////////////////////////////////////////////////


//   Single simulation run...

reset
str simsDir
simsDir = "/home/Simon/nC_projects/Vanier_Piriform_Cortex/simulations/"

str simReference
simReference = "Sim_2"

str targetDir
targetDir =  {strcat {simsDir} {simReference}}
targetDir =  {strcat {targetDir} {"/"}}

echo
echo
echo     Preparing recording of cell parameters
echo
echo

create neutral /fileout
str cellName
str compName
create neutral /fileout/cells
echo Created: /fileout/cells


//   Saving VOLTAGE on only one seg, id: 0, in the only cell in CellGroup_2

if (!{exists /fileout/cells/CellGroup_2})
    create neutral /fileout/cells/CellGroup_2
end

foreach cellName ({el /cells/CellGroup_2/#})
    if (!{exists /fileout{cellName}})
        create neutral /fileout{cellName}
    end

    ce {cellName}

//   Recording at segInOrigCell: Soma (Id: 0), segInMappedCell: Soma, section: Soma, ID: 0, ROOT SEGMENT, rad: 5.2, (0.0, 0.0, 0.0) -> (0.0, 21.3, 0.0), len: 21.3 (FINITE VOLUME)

    compName = {strcat {cellName} /Soma}
    str fileNameStr
    fileNameStr = {strcat {getpath {cellName} -tail} {".dat"} }
    create asc_file /fileout{compName}VOLTAGE
    setfield /fileout{compName}VOLTAGE    flush 1    leave_open 1    append 1 notime 1
    setfield /fileout{compName}VOLTAGE filename {strcat {targetDir} {fileNameStr}}
    
    addmsg {cellName}/Soma /fileout{compName}VOLTAGE SAVE Vm  //  .. 
    call /fileout{compName}VOLTAGE OUT_OPEN
    call /fileout{compName}VOLTAGE OUT_WRITE {getfield {cellName}/Soma Vm}

end

//////////////////////////////////////////////////////////////////////
//   This will run a full simulation when the file is executed
//////////////////////////////////////////////////////////////////////

reset
str startTimeFile
str stopTimeFile
startTimeFile = {strcat {targetDir} {"starttime"}}
stopTimeFile = {strcat {targetDir} {"stoptime"}}
sh {strcat {"date +%s.%N > "} {startTimeFile}}

echo Starting sim: Sim_2 on {genesisCore} with dur: {duration} dt: {dt} and steps: {steps} (Crank-Nicholson num integration method (11), using hsolve: true, chanmode: 0)
date +%F__%T__%N
step {steps}

echo Finished simulation reference: Sim_2
date +%F__%T__%N
echo Data stored in directory: {targetDir}

//   This will ensure the data files don't get written to again..


str fileElement
foreach fileElement ({el /fileout/cells/##[][TYPE=asc_file]})
end
foreach fileElement ({el /fileout/cells/##[][TYPE=event_tofile]})
    echo Closing {fileElement}

    call {fileElement} CLOSE
end

//   Saving file containing time details

float i, timeAtStep
create asc_file /fileout/timefile
setfield /fileout/timefile    flush 1    leave_open 1    append 1  notime 1
setfield /fileout/timefile filename {strcat {targetDir} {"time.dat"}}
call /fileout/timefile OUT_OPEN
for (i = 0; i <= {steps}; i = i + 1)
    timeAtStep = {dt} * i
    call /fileout/timefile OUT_WRITE {timeAtStep} 
end

call /fileout/timefile FLUSH


sh {strcat {"date +%s.%N > "} {stopTimeFile}}

openfile {startTimeFile} r
openfile {stopTimeFile} r
float starttime = {readfile {startTimeFile}}  
float stoptime =  {readfile {stopTimeFile}}  
float runTime = {stoptime - starttime}  
echo Simulation took : {runTime} seconds  
closefile {startTimeFile} 
closefile {stopTimeFile} 


str hostnameFile
hostnameFile = {strcat {targetDir} {"hostname"}}
sh {strcat {"hostname > "} {hostnameFile}}
openfile {hostnameFile} r
str hostnamestr = {readfile {hostnameFile}}
closefile {hostnameFile}

str simPropsFile
simPropsFile = {strcat {targetDir} {"simulator.props"}}
openfile {simPropsFile} w
writefile {simPropsFile} "RealSimulationTime="{runTime}
writefile {simPropsFile} "Host="{hostnamestr}
closefile {simPropsFile} 
