--アグレッシブ・クラウディアン
--Raging Cloudian
function c23639291.initial_effect(c)
	--Special Summon 1 "Cloudian" monster that was destroyed by its own effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc23639291(c23639291,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CUSTOM+c23639291)
	e1:SetTarget(c23639291.target)
	e1:SetOperation(c23639291.operation)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
	--Register when "Cloudian" monsters are sent to the GY
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetLabelObject(e1)
	e2:SetOperation(c23639291.regop)
	Duel.RegisterEffect(e2,0)
end
c23639291.counter_place_list={COUNTER_FOG}
c23639291.listed_series={SET_CLOUDIAN}
function c23639291.cfilter(c,e,tp)
	return c:IsSetCard(SET_CLOUDIAN) and c:IsControler(tp) and c:IsPreviousControler(tp)
		and c:IsReason(REASON_DESTROY) and c:GetReasonEffect() and c:GetReasonEffect():GetOwner()==c
		and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c23639291.regop(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:Filter(c23639291.cfilter,nil,e,tp)
	if #tg>0 then
		for tc in tg:Iter() do
			tc:RegisterFlagEffect(c23639291,RESET_CHAIN,0,1)
		end
		local g=e:GetLabelObject():GetLabelObject()
		if Duel.GetCurrentChain()==0 then g:Clear() end
		g:Merge(tg)
		g:Remove(function(c) return c:GetFlagEffect(c23639291)==0 end,nil)
		e:GetLabelObject():SetLabelObject(g)
		if Duel.GetFlagEffect(tp,c23639291)==0 then
			Duel.RegisterFlagEffect(tp,c23639291,RESET_CHAIN,0,1)
			Duel.RaiseEvent(eg,EVENT_CUSTOM+c23639291,e,0,tp,tp,0)
		end
	end
end
function c23639291.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=e:GetLabelObject():Filter(c23639291.cfilter,nil,e,tp)
	if chkc then return g:IsContains(chkc) and c23639291.cfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and #g>0 end
	local tg=nil
	if #g>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		tg=g:Select(tp,1,1,nil)
	else
		tg=g
	end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,1,tp,0)
end
function c23639291.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringc23639291(c23639291,0))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POS_E)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
	tc:AddCounter(COUNTER_FOG,1)
end