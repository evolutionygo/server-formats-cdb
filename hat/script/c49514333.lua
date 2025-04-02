--ソウル・オブ・スタチュー
--Tiki Soul
function c49514333.initial_effect(c)
	--Special Summon this card as an Effect monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc49514333(c49514333,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c49514333.target)
	e1:SetOperation(c49514333.activate)
	c:RegisterEffect(e1)
	--Set Trap cards that are monsters instead of sending them to the GY if they are destroyed
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_SEND_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c49514333.reptg)
	e2:SetValue(c49514333.repval)
	c:RegisterEffect(e2)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e2:SetLabelObject(g)
end
function c49514333.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
		Duel.IsPlayerCanSpecialSummonMonster(tp,c49514333,0,TYPE_MONSTER|TYPE_EFFECT,1000,1800,4,RACE_ROCK,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,0)
end
function c49514333.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,c49514333,0,TYPE_MONSTER|TYPE_EFFECT,1000,1800,4,RACE_ROCK,ATTRIBUTE_LIGHT) then return end
	c:AddMonsterAttribute(TYPE_EFFECT|TYPE_TRAP)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	c:AddMonsterAttributeComplete()
end
function c49514333.repfilter(c,tp)
	return c:IsOriginalType(TYPE_TRAP) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup()
		and c:IsReason(REASON_DESTROY) and c:GetDestination()==LOCATION_GRAVE
		and c:GetReasonPlayer()==1-tp and c:GetOwner()==tp and c:IsCanTurnSet()
end
function c49514333.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local count=eg:FilterCount(c49514333.repfilter,e:GetHandler(),tp)
		return count>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>=count
	end
	if Duel.SelectYesNo(tp,aux.Stringc49514333(c49514333,1)) then
		Duel.Hint(HINT_CARD,1-tp,c49514333)
		local replcg=e:GetLabelObject()
		replcg:Clear()
		local g=eg:Filter(c49514333.repfilter,e:GetHandler(),tp)
		for tc in g:Iter() do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
		Duel.ChangePosition(g,POS_FACEDOWN)
		Duel.RaiseEvent(g,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
		replcg:Merge(g)
		return true
	end
	return false
end
function c49514333.repval(e,c)
	return e:GetLabelObject():IsContains(c)
end