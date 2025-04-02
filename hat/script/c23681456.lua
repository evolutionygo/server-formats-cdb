--マドルチェ・ハッピーフェスタ
--Madolchepalooza
function c23681456.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c23681456.target)
	e1:SetOperation(c23681456.operation)
	c:RegisterEffect(e1)
end
c23681456.listed_series={0x71}
function c23681456.filter(c,e,tp)
	return c:IsSetCard(0x71) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23681456.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c23681456.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c23681456.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23681456.filter,tp,LOCATION_HAND,0,1,ft,nil,e,tp)
	if #g>0 then
		local fc23681456=e:GetHandler():GetFieldID()
		local tc=g:GetFirst()
		for tc in aux.Next(g) do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(c23681456,RESET_EVENT+RESETS_STANDARD,0,1,fc23681456)
			tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringc23681456(c23681456,0))
		end
		Duel.SpecialSummonComplete()
		g:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetLabel(fc23681456)
		e1:SetLabelObject(g)
		e1:SetCondition(c23681456.retcon)
		e1:SetOperation(c23681456.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c23681456.retfilter(c,fc23681456)
	return c:GetFlagEffectLabel(c23681456)==fc23681456
end
function c23681456.retcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c23681456.retfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c23681456.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c23681456.retfilter,nil,e:GetLabel())
	Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end