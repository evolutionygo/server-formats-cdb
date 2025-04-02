--同姓同名同盟条約
--Treaty on Uniform Nomenclature
function c13685271.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E|TIMING_ATTACK)
	e1:SetCondition(c13685271.condition)
	e1:SetTarget(c13685271.target)
	e1:SetOperation(c13685271.activate)
	c:RegisterEffect(e1)
end
function c13685271.cfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TOKEN)
end
function c13685271.get_count(g)
	if #g==0 then return 0 end
	local ret=0
	repeat
		local tc=g:GetFirst()
		g:RemoveCard(tc)
		local ct1=#g
		g:Remove(Card.IsCode,nil,tc:GetCode())
		local ct2=#g
		local c=ct1-ct2+1
		if c>ret then ret=c end
	until #g==0 or #g<=ret
	return ret
end
function c13685271.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c13685271.cfilter,tp,LOCATION_MZONE,0,nil)
	local ct=c13685271.get_count(g)
	e:SetLabel(ct)
	return ct==2 or ct==3
end
function c13685271.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,nil)
	if e:GetLabel()==2 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	else Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0) end
end
function c13685271.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c13685271.cfilter,tp,LOCATION_MZONE,0,nil)
	local ct=c13685271.get_count(g)
	if ct==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif ct==3 then
		local g=Duel.GetMatchingGroup(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end