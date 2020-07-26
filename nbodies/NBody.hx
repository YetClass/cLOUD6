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

    private static function advance(bodies :Array<Planet>)
    {
        for( i in 0...bodies.length )
        {
            var b = bodies[i];
            for( j in (i+1)...bodies.length )
            {
                var b2 = bodies[j];
                var dx = b.x - b2.x;
                var dy = b.y - b2.y;
                var dz = b.z - b2.z;
                var invDist = 1.0/Math.sqrt(dx*dx + dy*dy + dz*dz);
                var mag = invDist * invDist * invDist;
                b.vx -= dx * b2.mass * mag;
                b.vy -= dy * b2.mass * mag;
                b.vz -= dz * b2.mass * mag;
                b2.vx += dx * b.mass 