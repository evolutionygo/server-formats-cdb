--氷結界の封魔団
--Spellbreaker of the Ice Barrier
function c73061465.initial_effect(c)
	--Apply activation restriction
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc73061465(c73061465,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(aux.IceBarrierDiscardCost(c73061465.cfilter,false))
	e1:SetOperation(c73061465.operation)
	c:RegisterEffect(e1)
end
c73061465.listed_series={SET_ICE_BARRIER}
function c73061465.cfilter(c)
	return c:IsSetCard(SET_ICE_BARRIER) and c:IsMonster() and c:IsAbleToGraveAsCost()
end
function c73061465.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	--Neither player can activate Spell Cards
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c73061465.tgval)
	e1:SetReset(RESETS_STANDARD_PHASE_END,3)
	c:RegisterEffect(e1)
end
function c73061465.tgval(e,re,rp)
	return re:IsSpellEffect() and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end