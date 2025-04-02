--デーモンの雄叫び
--Archfiend's Roar
function c56246017.initial_effect(c)
	--Special summon 1 "Archfiend" monster from GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc56246017(c56246017,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER|TIMING_END_PHASE)
	e1:SetCost(c56246017.cost)
	e1:SetTarget(c56246017.target)
	e1:SetOperation(c56246017.activate)
	c:RegisterEffect(e1)
end
c56246017.listed_series={SET_ARCHFIEND}
function c56246017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c56246017.filter(c,e,tp)
	return c:IsSetCard(SET_ARCHFIEND) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c56246017.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c56246017.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c56246017.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c56246017.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c56246017.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		--Cannot be tributed
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(3303)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		tc:RegisterEffect(e2,true)
		--Destroyed during end phase
		local fc56246017=e:GetHandler():GetFieldID()
		tc:RegisterFlagEffect(c56246017,RESET_EVENT|RESETS_STANDARD,0,1,fc56246017)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_PHASE+PHASE_END)
		e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetCountLimit(1)
		e3:SetLabel(fc56246017)
		e3:SetLabelObject(tc)
		e3:SetCondition(c56246017.descon)
		e3:SetOperation(c56246017.desop)
		Duel.RegisterEffect(e3,tp)
	end
end
function c56246017.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(c56246017)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c56246017.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetLabelObject(),REASON_EFFECT)
end