/*
    Author:  Jason Ostrom
*/

import "hash"

rule test1
{
    condition:      
        hash.md5(0, filesize) == "0cfc227a87346c4d9e1d27d706a51ef4"
}

rule fin7_backdoors1_mswmex_client
{
    condition:      
        hash.md5(0, filesize) == "79e4fbfe24a81b3a2aeb3b3d3deb3d75"
}

rule fin7_backdoors2_pho12exe_client
{
    condition:      
        hash.md5(0, filesize) == "49a39b84aff09fee66bb853130bd860d"
}

rule fin7_backdoors3_pho32js_client
{
    condition:      
        hash.md5(0, filesize) == "e40a97425b26d22f7df0dc8a9e2b2f0e"
}