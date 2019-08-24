parameter etaToAp, ecc.

print "Circularizing to maintain " + etaToAp + "s to Apoapsis until |Ap - Pe| < " + ecc + "m...".

SAS OFF.

SET Kp to 0.16.
SET Ki to 0.006.
SET Kd to 0.006.
SET pid to pidloop(Kp, Ki, Kd).
SET pid:setpoint to etaToAp.

SET thrott to 0.
LOCK THROTTLE to thrott.

UNTIL abs(SHIP:PERIAPSIS - SHIP:APOAPSIS) < ecc {
	SET thrott to thrott + pid:update(time:seconds, ETA:APOAPSIS).
	if thrott > 1 { SET thrott to 1. }
	if thrott < 0 { SET thrott to 0. }
	WAIT 0.001.
}

LOCK THROTTLE to 0.

print "Circularization Program Complete".
