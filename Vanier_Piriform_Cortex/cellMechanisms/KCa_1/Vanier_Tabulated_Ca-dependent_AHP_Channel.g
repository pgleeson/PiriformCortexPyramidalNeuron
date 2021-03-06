// M. C. Vanier and J. M. Bower
// A Comparative Survey of Automated Parameter-Searching Methods
// for Compartmental Neural Models

// Description of the simplified layer 2 pyramidal cell model
// (model 5).  Active conductances and reversal potentials.
// Channel descriptions are in the GENESIS neural modeling language;
// for more information see "The Book of GENESIS, 2nd. Ed." by J. M. 
// Bower and David Beeman, Springer/Telos.  All voltage- or calcium-
// dependent ionic channels are very standard Hodgkin-Huxley-type
// channels.

// genesis

// CONSTANTS:

// channel equilibrium potentials (V)
float EREST_ACT = -0.0743 // superficial pyramidal cell resting potential
float ENA       =  0.055
float EK        = -0.075
float ECA       =  0.080

//========================================================================
//             Tabulated Ca-dependent K AHP Channel
//========================================================================

function make_%Name%
	str chanpath = "/library/%Name%"
	if ({exists {chanpath}})
	    return
	end

    create tabchannel {chanpath}
    setfield {chanpath}             \
        Ek     -96e-03     \
        Gbar   %Max Conductance Density%           \
        Ik     0           \    
        Gk     0           \
        Xpower 0           \
        Ypower 0           \
        Zpower 1

    float xmin  = 0.0
    float xmax  = 5.2e-06
    int   xdivs = 50

    call {chanpath} TABCREATE Z {xdivs} {xmin} {xmax}

    int i
    float x, dx, y

    dx = (xmax - xmin) / xdivs
    x  = xmin

    for (i = 0; i <= xdivs; i = i + 1)
        if (x < 4.2e-06)
            y = 10.0 * x / 8.2e-06
        else
            y = 10.0
        end

        setfield {chanpath} Z_A->table[{i}] {y}
        setfield {chanpath} Z_B->table[{i}] {y + 0.5}
        x = x + dx
    end

    setfield {chanpath} Z_A->calc_mode 0 Z_B->calc_mode 0
    call {chanpath} TABFILL Z 3000 0

    if (!{exists {chanpath} addmsg1})
        addfield {chanpath} addmsg1
    end

    setfield  {chanpath} addmsg1 "../Ca_buffer . CONCEN Ca"
end

