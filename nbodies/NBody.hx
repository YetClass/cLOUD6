/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * Translated from Christoph Bauer's nbody.c by Ian Martins
 */

typedef Planet = {
    var x :Float;
    var y :Float;
    var z :Float;
    var vx :Float;
    var vy :Float;
    var vz :Float;
    var mass :Float;
}


class NBody
{
    private static var SOLAR_MASS = 4 * Math.PI * Math.PI;
    private static var DAYS_PER_YEAR = 365.24;
    private static var DT = 1e-2;
    private static var RECIP_DT = (1.0/DT);

    private static function advance(bodies :