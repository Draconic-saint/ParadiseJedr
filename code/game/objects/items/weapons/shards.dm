// Glass shards

/obj/item/weapon/shard
	name = "glass shard"
	icon = 'icons/obj/shards.dmi'
	icon_state = "large"
	sharp = 1
	edge = 1
	desc = "Could probably be used as ... a throwing weapon?"
	w_class = 1.0
	force = 5.0
	throwforce = 10.0
	item_state = "shard-glass"
	materials = list(MAT_GLASS=MINERAL_MATERIAL_AMOUNT)
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/weapon/shard/suicide_act(mob/user)
		to_chat(viewers(user), pick("\red <b>[user] is slitting \his wrists with \the [src]! It looks like \he's trying to commit suicide.</b>",
									"\red <b>[user] is slitting \his throat with \the [src]! It looks like \he's trying to commit suicide.</b>"))
		return (BRUTELOSS)

/obj/item/weapon/shard/New()
	src.icon_state = pick("large", "medium", "small")
	switch(src.icon_state)
		if("small")
			src.pixel_x = rand(-12, 12)
			src.pixel_y = rand(-12, 12)
		if("medium")
			src.pixel_x = rand(-8, 8)
			src.pixel_y = rand(-8, 8)
		if("large")
			src.pixel_x = rand(-5, 5)
			src.pixel_y = rand(-5, 5)
		else
	..()

/obj/item/weapon/shard/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = I
		if(WT.remove_fuel(0, user))
			var/obj/item/stack/sheet/glass/NG = new (user.loc)
			for(var/obj/item/stack/sheet/glass/G in user.loc)
				if(G == NG)
					continue
				if(G.amount >= G.max_amount)
					continue
				G.attackby(NG, user)
			to_chat(user, "<span class='notice'>You add the newly-formed glass to the stack. It now contains [NG.amount] sheet\s.</span>")
			qdel(src)
	..()

/obj/item/weapon/shard/Crossed(AM as mob|obj)
	if(isliving(AM))
		var/mob/living/M = AM
		if (M.incorporeal_move || M.flying)//you are incorporal or flying..no shard stepping!
			return
		to_chat(M, "\red <B>You step on \the [src]!</B>")
		playsound(src.loc, 'sound/effects/glass_step.ogg', 50, 1) // not sure how to handle metal shards with sounds
		if(ishuman(M))
			var/mob/living/carbon/human/H = M

			if( !H.shoes && ( !H.wear_suit || !(H.wear_suit.body_parts_covered & FEET) ) )
				var/obj/item/organ/external/affecting = H.get_organ(pick("l_foot", "r_foot"))
				if(!affecting)
					return
				if(affecting.status & ORGAN_ROBOT)
					return
				H.Weaken(3)
				if(affecting.take_damage(5, 0))
					H.UpdateDamageIcon()
				H.updatehealth()
	..()

// Shrapnel

/obj/item/weapon/shard/shrapnel
	name = "shrapnel"
	icon = 'icons/obj/shards.dmi'
	icon_state = "shrapnellarge"
	desc = "A bunch of tiny bits of shattered metal."

/obj/item/weapon/shard/shrapnel/New()

	src.icon_state = pick("shrapnellarge", "shrapnelmedium", "shrapnelsmall")
	switch(src.icon_state)
		if("shrapnelsmall")
			src.pixel_x = rand(-12, 12)
			src.pixel_y = rand(-12, 12)
		if("shrapnelmedium")
			src.pixel_x = rand(-8, 8)
			src.pixel_y = rand(-8, 8)
		if("shrapnellarge")
			src.pixel_x = rand(-5, 5)
			src.pixel_y = rand(-5, 5)
		else
	return


// plasma shards, moved here from old xenoarch code

/obj/item/weapon/shard/plasma
	name = "plasma shard"
	desc = "A shard of plasma glass. Considerably tougher then normal glass shards. Apparently not tough enough to be a window."
	force = 8.0
	throwforce = 15.0
	icon_state = "plasmalarge"
	sharp = 1
	edge = 1

/obj/item/weapon/shard/plasma/New()

	src.icon_state = pick("plasmalarge", "plasmamedium", "plasmasmall")
	switch(src.icon_state)
		if("plasmasmall")
			src.pixel_x = rand(-12, 12)
			src.pixel_y = rand(-12, 12)
		if("plasmamedium")
			src.pixel_x = rand(-8, 8)
			src.pixel_y = rand(-8, 8)
		if("plasmalarge")
			src.pixel_x = rand(-5, 5)
			src.pixel_y = rand(-5, 5)
		else
	return

/obj/item/weapon/shard/plasma/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	..()
	if ( istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(0, user))
			var/obj/item/stack/sheet/plasmaglass/NG = new (user.loc)
			for (var/obj/item/stack/sheet/plasmaglass/G in user.loc)
				if(G==NG)
					continue
				if(G.amount>=G.max_amount)
					continue
				G.attackby(NG, user, params)
				usr << "You add the newly-formed plasma glass to the stack. It now contains [NG.amount] sheets."
			//SN src = null
			qdel(src)
			return
	return ..()
