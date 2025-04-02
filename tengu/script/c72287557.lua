--ヘル・ポリマー
--Chthonian Polymer
function c72287557.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c72287557.condition)
	e1:SetCost(c72287557.cost)
	e1:SetTarget(c72287557.target)
	e1:SetOperation(c72287557.activate)
	c:RegisterEffect(e1)
end
function c72287557.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return #eg==1 and tc:IsControler(1-tp) and tc:IsSummonType(SUMMON_TYPE_FUSION)
end
function c72287557.cfilter(c,tp,eg)
	return Duel.GetMZoneCount(tp,c)>0 and not eg:IsContains(c)
end
function c72287557.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c72287557.cfilter,1,false,nil,nil,tp,eg) end
	local g=Duel.SelectReleaseGroupCost(tp,c72287557.cfilter,1,1,false,nil,nil,tp,eg)
	Duel.Release(g,REASON_COST)
end
function c72287557.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return eg:GetFirst():IsCanBeEffectTarget(e) and eg:GetFirst():IsAbleToChangeControler() end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,eg,1,0,0)
end
function c72287557.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end