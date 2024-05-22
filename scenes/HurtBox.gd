extends Area2D

@export_enum("Cooldown", "HitOnce", "DisabledHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: # cooldown
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1: # HitOnce
					pass
				2: # DisableHitbox
					if area.has_method("tempdisabled"):
						area.tempdisabled()
			var damage = area.damage
			emit_signal("hurt", damage)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
