![Image of Datafile](https://i.imgur.com/2DnlQyU.png)
# Datafiles
ORIGINAL PLUGIN BY JAMES - PERMISSION FOR RELEASE GRANTED

_________________________
<b>INFORMATION</b>
_________________________

An edited version I worked on for a community that closed (unfinished).

Features different from the version by James:
1. BOL removal fixed.
2. Employment status config implemented.
3. Actual datapad items and sweps that switches materials when you use the datafile commands and need to be held in order to use the datafile commands.
4. CWU and CMU pda for those factions that allows either adding notes or medical notes.
5. RL and SCN able to use datafile management, restriction and reset commands.
6. Restriction now restricts datafile to be viewed only by RL and SCN.
7. A bunch of sharedvars added to use with other plugins.
8. Fixed some incorrect datastream names.
9. Transfered datafile SQL information to characters table instead of a whole new datafile table (did this because data transfered between characters if characters were deleted).

What does the datapad/pda's do?
1. Combine Datapad gives access to the /datafile, /managedatafile, /restrictdatafile, /scrubdatafile commands.
2. CWU datapad gives access to a limited version of the /datafile (adding notes) and custom CWU only objectives editable by CWU leader settable by /setcwulead and /removecwulead.
3. CMU datapad gives access to a limited version of the /datafile (adding medical notes) and custom CMU only objectives editable by CMU leader settable by /setcmulead and /removecmulead.

_________________________
<b>SHAREDVARS</b> (playerVars:Number only) -- primarily used for datapad sweps material switching to work properly
_________________________

1. LoyaltyPoints
2. BOL
3. LoyaltyTier
4. PlayerIsRestricted
5. DatafileOpen
6. ManagementOpen
7. PlayerObjectivesOpen
8. PlayerEnterOpen

_________________________
<b>UNFINISHED PARTS</b>
_________________________

1. Didn't make SQL table creation automatic.
2. Didn't do CWU & CMU PDA attachments item-wise.
3. Apparently there's an error which I'm unable to recreate with the datapad derma.

_________________________
<b>FOR IT TO WORK YOU NEED TO DO THIS</b>
_________________________

Add these columns to characters SQL table with default variable "fill" (I didn't bother to make it create itself):
_GenericData
_Datafile

_________________________
<b>STREAMABLES OF THE PLUGIN(S)</b> - videos may or may not differ from what the plugin looks like now.
_________________________

1. https://streamable.com/vfjmu
2. https://streamable.com/9uou4
