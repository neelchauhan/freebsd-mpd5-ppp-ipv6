# IPv6 Scripts for FreeBSD MPD5 PPPoE/L2TP servers

While my job (as of now) isn't in networking or telecom, it's a hobby of mine
to play with computer networks. One project of mine is to set up a PPPoE
server/client setup in VMs.

I'm also a [FreeBSD](https://www.freebsd.org/) person, and would like to set
up a dual-stack IPv6 PPPoE server with FreeBSD's [mpd](mpd.sourceforge.net/)
instead of using Linux.

## Working

 * IPV6CP

 * Assigning an IPv6 address via `rtadvd` (server) and `rtsol` (client) via hardcoded prefix

## TODO

 * Specifying the IPv6 WAN/LAN prefix in a config file

 * DHCPv6

 * DHCPv6-PD

 * Static IPv6 Prefix Allocation/Delegation via RADIUS

 * Fix the generation of `rtadvd` configs
