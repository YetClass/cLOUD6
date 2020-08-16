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
                b2.vx += dx * b.mass * mag;
                b2.vy += dy * b.mass * mag;
                b2.vz += dz * b.mass * mag;
            }
        }
        for( b in bodies )
        {
            b.x += b.vx;
            b.y += b.vy;
            b.z += b.vz;
        }
    }

    private static function energy(bodies :Array<Planet>)
    {
        var e = 0.0;
        for( i in 0...bodies.length )
        {
            var b = bodies[i];
            e += 0.5 * b.mass * (b.vx*b.vx + b.vy*b.vy + b.vz*b.vz);
            for( j in (i+1)...bodies.length )
            {
                var b2 = bodies[j];
                var dx = b.x - b2.x;
                var dy = b.y - b2.y;
                var dz = b.z - b2.z;
                var distance = Math.sqrt(dx*dx + dy*dy + dz*dz);
                e -= (b.mass * b2.mass) / distance;
            }
        }
        return e;
    }

    private static function offsetMomentum(bodies :Array<Planet>)
    {
        var px = 0.0,
            py = 0.0,
            pz = 0.0;
        for( b in bodies )
        {
            px += b.vx * b.mass;
            py += b.vy * b.mass;
            pz += b.vz * b.mass;
        }
        bodies[0].vx = - px / SOLAR_MASS;
        bodies[0].vy = - py / SOLAR_MASS;
        bodies[0].vz = - pz / SOLAR_MASS;
    }

    /*
     * Rescale certain properties of bodies. That allows doing
     * consequential advance()'s as if dt were equal to 1.0.
     *
     * When all advances done, rescale bodies back to obtain correct energy.
     */
    private static function scaleBodies(bodies :Array<Planet>, scale :Float)
    {
        for( b in bodies )
        {
            b.mass *= scale*scale;
            b.vx *= scale;
            b.vy *= scale;
            b.vz *= scale;
        }
    }

    inline private static function round(val :Float)
    {
        return Math.round(