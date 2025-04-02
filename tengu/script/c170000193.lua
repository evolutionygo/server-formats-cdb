--真紅眼の黒竜剣 (Anime)
--Red-Eyes Black Dragon Sword (Anime)
function c170000193.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	Fusion.AddProcCodeFun(c,CARD_REDEYES_B_DRAGON,46232525,1,true,true)
	aux.AddEquipProcedure(c)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--Atk Boost
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c170000193.value)
	c:RegisterEffect(e4)
end
c170000193.listed_names={CARD_REDEYES_B_DRAGON}
c170000193.material_setcode={0x3b}
function c170000193.hermos_filter(c)
	return c:IsCode(CARD_REDEYES_B_DRAGON)
end
function c170000193.value(e,c)
	return Duel.GetMatchingGroupCount(c170000193.atkfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*500
end
function c170000193.atkfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end