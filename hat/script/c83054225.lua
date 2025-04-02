--緊急発進
function c83054225.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c83054225.spcon)
	e1:SetTarget(c83054225.sptg)
	e1:SetOperation(c83054225.spop)
	c:RegisterEffect(e1)
end
c83054225.listed_series={0x101b}
c83054225.listed_names={TOKEN_MECHA_PHANTOM_BEAST}
function c83054225.cfilter(c)
	return not c:IsType(TYPE_TOKEN)
end
function c83054225.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>Duel.GetMatchingGroupCount(c83054225.cfilter,tp,LOCATION_MZONE,0,nil)
end
function c83054225.spfilter(c,e,tp)
	return c:IsSetCard(0x101b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c83054225.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c83054225.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if chk==0 then
		if Duel.GetFlagEffect(tp,c83054225)~=0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return false end
		return ct>0 and Duel.CheckReleaseGroupCost(tp,Card.IsCode,1,false,nil,nil,TOKEN_MECHA_PHANTOM_BEAST)
	end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ct=1 end
	local g=Duel.SelectReleaseGroupCost(tp,Card.IsCode,1,ct,false,nil,nil,TOKEN_MECHA_PHANTOM_BEAST)
	Duel.Release(g,REASON_COST)
	e:SetLabel(#g)
	Duel.RegisterFlagEffect(tp,c83054225,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,#g,tp,LOCATION_DECK)
end
function c83054225.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ft=1 end
	local ct=e:GetLabel()
	if ft<ct then return end
	local g=Duel.GetMatchingGroup(c83054225.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if #g<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,ct,ct,nil)
	local fc83054225=e:GetHandler():GetFieldID()
	local tc=sg:GetFirst()
	for tc in aux.Next(sg) do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(c83054225,RESET_EVENT+RESETS_STANDARD,0,1,fc83054225)
	end
	Duel.SpecialSummonComplete()
	sg:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetLabel(fc83054225)
	e1:SetLabelObject(sg)
	e1:SetCondition(c83054225.retcon)
	e1:SetOperation(c83054225.retop)
	Duel.RegisterEffect(e1,tp)
end
function c83054225.retfilter(c,fc83054225)
	return c:GetFlagEffectLabel(c83054225)==fc83054225
end
function c83054225.retcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c83054225.retfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c83054225.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c83054225.retfilter,nil,e:GetLabel())
	Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end