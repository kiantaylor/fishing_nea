extends Node


class_name Ecosystem


var levels=[]
var depth=0.0
var size=500
func _init_(lv,d,s):
	levels=lv
	depth=d
	size=s
	for i in levels:
		i.debug_display()
func tick():
	for i in levels:
		print(levels.reduce(sum_mass, 0))
func sum_mass(accum,item):
	return accum+item.get_mass()
