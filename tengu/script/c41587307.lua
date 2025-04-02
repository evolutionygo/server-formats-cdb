--折れ竹光
--Broken Bamboo Sword
function c41587307.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Gains 0 ATK
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_EQUIP)
	e0:SetCode(EFFECT_UPDATE_ATTACK)
	e0:SetValue(0)
	c:RegisterEffect(e0)
end