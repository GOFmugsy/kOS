parameter maxAlt.

print "Beginning PID Loop to " + maxAlt + "m...".

SET g to KERBIN:MU / KERBIN:RADIUS^2.
LOCK accvec TO SHIP:SENSORS:ACC - SHIP:SENSORS:GRAV.
LOCK gforce TO accvec:MAG / g.

SET Kp TO 0.01.
SET Ki TO 0.006. 
SET Kd TO 0.006. 
SET pid TO pidloop(Kp, Ki, Kd).
SET pid:setpoint to 1.2.

SET thrott to 1.
LOCK THROTTLE TO thrott.

UNTIL SHIP:ALTITUDE > maxAlt {
	SET thrott TO thrott + pid:update(time:seconds, gforce).
	WAIT 0.001.
}
SET thrott to 0.

