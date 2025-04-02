--Elemental HERO Escurc511310003ao (Anime)
--AlphaKretin
function c511310003.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,0x3008),aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_DARK))
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c511310003.atkup)
	c:RegisterEffect(e3)
end
c511310003.material_setcode={0x8,0x3008}
function c511310003.atkup(e,c)
	return Duel.GetMatchingGroupCount(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE,0,nil,0x3008)*100
end