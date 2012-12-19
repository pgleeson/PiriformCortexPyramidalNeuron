

// **************************************************
// File generated by: neuroConstruct v1.6.1 
// **************************************************

// This file holds the implementation in GENESIS of the Cell Mechanism:
// Na_Hippo_ChannelML (Type: Channel mechanism, Model: ChannelML based process)

// with parameters: 
// /channelml/@units = SI Units 
// /channelml/notes = ChannelML file containing a single Channel description 
// /channelml/channel_type/@name = Na_Hippo_ChannelML 
// /channelml/channel_type/@density = yes 
// /channelml/channel_type/status/@value = stable 
// /channelml/channel_type/status/comment = Implementation of Hippocampal sodium channel 
// /channelml/channel_type/status/contributor/name = Simon O'Connor 
// /channelml/channel_type/notes = Hippocampal Na channel in Vanier and Bower (1999) 
// /channelml/channel_type/authorList/modelTranslator/name = Simon O'Connor 
// /channelml/channel_type/authorList/modelTranslator/institution = unaffiliated 
// /channelml/channel_type/authorList/modelTranslator/email = simon.oconnor - at - btinternet.com 
// /channelml/channel_type/publication/fullTitle = M.C. Vanier and J.M. Bower A comparative survey of automated parameter-search methods for compartmental neural models. Journal of Computational Neuros ... 
// /channelml/channel_type/publication/pubmedRef = http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&amp;db=pubmed&amp;dopt=Abstract&amp;list_uids=10515252 
// /channelml/channel_type/neuronDBref/modelName = Na channels 
// /channelml/channel_type/neuronDBref/uri = http://senselab.med.yale.edu/senselab/NeuronDB/channelGene2.htm#table2 
// /channelml/channel_type/current_voltage_relation/@cond_law = ohmic 
// /channelml/channel_type/current_voltage_relation/@ion = na 
// /channelml/channel_type/current_voltage_relation/@default_erev = 0.055 
// /channelml/channel_type/current_voltage_relation/@default_gmax = 2800 
// /channelml/channel_type/current_voltage_relation/gate[1]/@name = m 
// /channelml/channel_type/current_voltage_relation/gate[1]/@instances = 3 
// /channelml/channel_type/current_voltage_relation/gate[1]/closed_state/@id = m0 
// /channelml/channel_type/current_voltage_relation/gate[1]/open_state/@id = m 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@name = alpha 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@from = m0 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@to = m 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@expr = 320.0e3*(v - 0.0362)/-1.0 + (exp ((v + 0.0362)/-0.004)) 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@name = beta 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@from = m 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@to = m0 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@expr = 280.0e3*(v + 0.0092)/-1.0 + (exp ((v + 0.0092)/0.005)) 
// /channelml/channel_type/current_voltage_relation/gate[2]/@name = h 
// /channelml/channel_type/current_voltage_relation/gate[2]/@instances = 1 
// /channelml/channel_type/current_voltage_relation/gate[2]/closed_state/@id = h0 
// /channelml/channel_type/current_voltage_relation/gate[2]/open_state/@id = h 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[1]/@name = alpha 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[1]/@from = h0 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[1]/@to = h 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[1]/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[1]/@expr = 128.0 /(exp ((v + 0.0323)/0.018)) 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[2]/@name = beta 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[2]/@from = h 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[2]/@to = h0 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[2]/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate[2]/transition[2]/@expr = 4000/(1.0 + (exp ((v + 0.0093)/-0.0005))) 
// /channelml/channel_type/impl_prefs/table_settings/@max_v = 0.1 
// /channelml/channel_type/impl_prefs/table_settings/@min_v = -0.1 
// /channelml/channel_type/impl_prefs/table_settings/@table_divisions = 3000 

// File from which this was generated: /home/Simon/nC_projects/Vanier_Piriform_Cortex/cellMechanisms/Na_Hippo_ChannelML/NaChannel_HH.xml

// XSL file with mapping to simulator: /home/Simon/nC_projects/Vanier_Piriform_Cortex/cellMechanisms/Na_Hippo_ChannelML/ChannelML_v1.8.1_GENESIStab.xsl



// This is a GENESIS script file generated from a ChannelML v1.8.1 file
// The ChannelML file is mapped onto a tabchannel object


// Units of ChannelML file: SI Units, units of GENESIS file generated: SI Units

/*
    ChannelML file containing a single Channel description
*/

function make_Na_Hippo_ChannelML

        /*
            Hippocampal Na channel in Vanier and Bower (1999)

            
Reference: M.C. Vanier and J.M. Bower A comparative survey of automated parameter-search methods for compartmental neural models. Journal of Computational Neuroscience 7, 149-171. 1999
            Pubmed: http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=pubmed&dopt=Abstract&list_uids=10515252

        */
        

        str chanpath = "/library/Na_Hippo_ChannelML"

        if ({exists {chanpath}})
            return
        end
        
        create tabchannel {chanpath}
            

        setfield {chanpath} \ 
            Ek              0.055 \
            Ik              0  \
            Xpower          3 \
            Ypower          1
        
        setfield {chanpath} \
            Gbar 2800 \
            Gk              0 

        
        // No Q10 temperature adjustment found
        float temp_adj_m = 1
        float temp_adj_h = 1
    

        float tab_divs = 3000
        float v_min = -0.1

        float v_max = 0.1

        float v, dv, i
            
        // Creating table for gate m, using name X for it here

        float dv = ({v_max} - {v_min})/{tab_divs}
            
        call {chanpath} TABCREATE X {tab_divs} {v_min} {v_max}
                
        v = {v_min}

            

        for (i = 0; i <= ({tab_divs}); i = i + 1)
            
            // Looking at rate: alpha
                

            float alpha
                
                        
            // Found a generic form of rate equation for alpha, using expression: 320.0e3*(v - 0.0362)/-1.0 + (exp ((v + 0.0362)/-0.004))
            // Will translate this for GENESIS compatibility...
                    alpha = 320.0e3*{v - 0.0362}/-1.0 + {exp {{v + 0.0362}/-0.004}}
            
            // Looking at rate: beta
                

            float beta
                
                        
            // Found a generic form of rate equation for beta, using expression: 280.0e3*(v + 0.0092)/-1.0 + (exp ((v + 0.0092)/0.005))
            // Will translate this for GENESIS compatibility...
                    beta = 280.0e3*{v + 0.0092}/-1.0 + {exp {{v + 0.0092}/0.005}}
            

            // Using the alpha and beta expressions to populate the tables

            float tau = 1/(temp_adj_m * (alpha + beta))
            
            setfield {chanpath} X_A->table[{i}] {temp_adj_m * alpha}
            setfield {chanpath} X_B->table[{i}] {temp_adj_m * (alpha + beta)}
                    
            v = v + dv

        end // end of for (i = 0; i <= ({tab_divs}); i = i + 1)
            
        setfield {chanpath} X_A->calc_mode 1 X_B->calc_mode 1
                    
        // Creating table for gate h, using name Y for it here

        float dv = ({v_max} - {v_min})/{tab_divs}
            
        call {chanpath} TABCREATE Y {tab_divs} {v_min} {v_max}
                
        v = {v_min}

            

        for (i = 0; i <= ({tab_divs}); i = i + 1)
            
            // Looking at rate: alpha
                

            float alpha
                
                        
            // Found a generic form of rate equation for alpha, using expression: 128.0 /(exp ((v + 0.0323)/0.018))
            // Will translate this for GENESIS compatibility...
                    alpha = 128.0 /{exp {{v + 0.0323}/0.018}}
            
            // Looking at rate: beta
                

            float beta
                
                        
            // Found a generic form of rate equation for beta, using expression: 4000/(1.0 + (exp ((v + 0.0093)/-0.0005)))
            // Will translate this for GENESIS compatibility...
                    beta = 4000/{1.0 + {exp {{v + 0.0093}/-0.0005}}}
            

            // Using the alpha and beta expressions to populate the tables

            float tau = 1/(temp_adj_h * (alpha + beta))
            
            setfield {chanpath} Y_A->table[{i}] {temp_adj_h * alpha}
            setfield {chanpath} Y_B->table[{i}] {temp_adj_h * (alpha + beta)}
                    
            v = v + dv

        end // end of for (i = 0; i <= ({tab_divs}); i = i + 1)
            
        setfield {chanpath} Y_A->calc_mode 1 Y_B->calc_mode 1
                    


end

