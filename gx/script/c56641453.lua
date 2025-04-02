--コクーン・ヴェール
--Cocoon Veil
function c56641453.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc56641453(c56641453,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c56641453.cost)
	e1:SetTarget(c56641453.target)
	e1:SetOperation(c56641453.activate)
	c:RegisterEffect(e1)
end
c56641453.listed_series={SET_CHRYSALIS}
function c56641453.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(SET_CHRYSALIS)
		and Duel.IsExistingMatchingCard(c56641453.spfilter,tp,LOCATION_HAND|LOCATION_DECK|LOCATION_GRAVE,LOCATION_GRAVE,1,nil,c,e,tp)
end
function c56641453.spfilter(c,tc,e,tp)
	return tc:ListsCode(c:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c56641453.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c56641453.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroupCost(tp,c56641453.cfilter,1,false,aux.ReleaseCheckMMZ,nil,e,tp)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg=Duel.SelectReleaseGroupCost(tp,c56641453.cfilter,1,1,false,aux.ReleaseCheckMMZ,nil,e,tp)
	Duel.Release(rg,REASON_COST)
	Duel.SetTargetCard(rg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND|LOCATION_DECK|LOCATION_GRAVE)
end
function c56641453.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c56641453.damval)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e2,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c56641453.spfilter),tp,LOCATION_HAND|LOCATION_DECK|LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,tc,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c56641453.damval(e,re,val,r,rp,rc)
	if r&REASON_EFFECT~=0 then
		return 0
	else
		return val
	end
end