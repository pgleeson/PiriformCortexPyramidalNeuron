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

// ===========================================================================
//                      Calcium buffer
// ===========================================================================

function make_%Name%
	str chanpath = "/library/%Name%"
	if ({exists {chanpath}})
	    return
	end

    create Ca_concen {chanpath}

    setfield {chanpath}            \
        tau     0.025           \  // sec
        B       7.4e+6          \  // (asymptotic) conc/current
        Ca_base 50e-09             // M

    addfield {chanpath} addmsg1
    setfield {chanpath} addmsg1 "../Olfactory_Ca . I_Ca Ik"
end
