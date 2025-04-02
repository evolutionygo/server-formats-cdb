--罡炎星－リシュンキ
--Brotherhood of the Fire Fist - Kirin
function c89856523.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_FIRE),1,1,aux.NonTunerEx(Card.IsSetCard,0x79),1,99)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc89856523(c89856523,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c89856523.setcon)
	e1:SetTarget(c89856523.settg)
	e1:SetOperation(c89856523.setop)
	c:RegisterEffect(e1)
	--atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c89856523.atkval)
	c:RegisterEffect(e2)
end
c89856523.listed_series={0x7c,0x79}
function c89856523.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c89856523.filter(c)
	return c:IsSetCard(0x7c) and c:IsSpellTrap() and c:IsSSetable()
end
function c89856523.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89856523.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c89856523.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c89856523.filter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c89856523.atkfilter(c)
	return c:IsFaceup() and c:IsSpellTrap()
end
function c89856523.atkval(e,c)
	return Duel.GetMatchingGroupCount(c89856523.atkfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil)*-100
end