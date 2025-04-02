--Superheavy Samurai Ninja Sarutobi
function c511009065.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunctionEx(Card.IsRace,RACE_MACHINE),1,1,aux.NonTunerEx(Card.IsSetCard,0x9a),1,99)
	c:EnableReviveLimit()
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009065(96029574,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511009065.destg)
	e1:SetCondition(c511009065.descon)
	e1:SetOperation(c511009065.desop)
	c:RegisterEffect(e1)
	--defence attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DEFENSE_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c511009065.listed_series={0x9a}
function c511009065.cfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511009065.descon(e,tp,eg,ep,ev,re,r,rp)
		return not Duel.IsExistingMatchingCard(c511009065.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c511009065.desfilter(c)
	return c:IsSpellTrap() and c:IsDestructable()
end
function c511009065.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chkc then return chkc:IsOnField() and c511009065.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009065.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009065.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511009065.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local p=tc:GetControler()
		if Duel.Destroy(tc,REASON_EFFECT)==0 then return end
		Duel.Damage(p,500,REASON_EFFECT)
	end
end