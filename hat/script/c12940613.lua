--マドルチェ・マナー
--Madolche Lesson
function c12940613.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c12940613.condition)
	e1:SetTarget(c12940613.target)
	e1:SetOperation(c12940613.activate)
	c:RegisterEffect(e1)
end
c12940613.listed_series={0x71}
function c12940613.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c12940613.tdfilter1(c)
	return c:IsMonster() and c:IsSetCard(0x71) and c:IsAbleToDeck()
end
function c12940613.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c12940613.tdfilter1(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,0x71),tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c12940613.tdfilter1,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c12940613.tdfilter1,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetPossibleOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
end
function c12940613.tdfilter2(c)
	return c:IsMonster() and c:IsAbleToDeck()
end
function c12940613.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc and tc:IsRelateToEffect(e)) or Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)==0 then return end
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,0x71),tp,LOCATION_MZONE,0,nil)
	local ct=0
	for tc in aux.Next(g) do
	local preatk=tc:GetAttack()
	local predef=tc:GetDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		if preatk~=tc:GetAttack() or predef~=tc:GetDefense() then ct=ct+1 end
	end
	if ct==0 then return end
	local dg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c12940613.tdfilter2),tp,LOCATION_GRAVE,0,nil)
	if #dg~=0 and Duel.SelectYesNo(tp,aux.Stringc12940613(c12940613,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		Duel.SendtoDeck(dg:Select(tp,1,1,nil),nil,2,REASON_EFFECT)
	end
end