--W－ウィング・カタパルト
--W-Wing Catapult (Pre-Errata)
function c511002901.initial_effect(c)
	--equip
	aux.AddUnionProcedure(c,c511002901.filter,true)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(400)
	e3:SetCondition(aux.IsUnionState)
	c:RegisterEffect(e3)
	--Def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(400)
	e4:SetCondition(aux.IsUnionState)
	c:RegisterEffect(e4)
end
c511002901.old_union=true
c511002901.listed_names={51638941}
function c511002901.filter(c)
	return c:IsFaceup() and c:IsCode(51638941) and c:GetUnionCount()==0
end