--閻魔の裁き (Manga)
--Enma's Judgment (Manga)
Duel.EnableUnofficialRace(RACE_YOKAI)
function c511002274.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002274(c511002274,0))
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c511002274.condition)
	e1:SetTarget(c511002274.target)
	e1:SetOperation(c511002274.activate)
	c:RegisterEffect(e1)
end
c511002274.listed_names={68722455}
function c511002274.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain(true)==0 and ep==1-tp
end
function c511002274.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,#eg,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,#eg,0,0)
end
function c511002274.cfilter(c)
	return c:IsMonster() and c:IsRace(RACE_YOKAI) and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c,true)
end
function c511002274.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsCode(68722455)
end
function c511002274.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	local rg=Duel.GetMatchingGroup(c511002274.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local spg=Duel.GetMatchingGroup(c511002274.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>-5 and #rg>4 and aux.SelectUnselectGroup(rg,e,tp,5,5,aux.ChkfMMZ(1),0)
		and #spg>0 and Duel.SelectYesNo(tp,aux.Stringc511002274(c511002274,1)) then
		Duel.BreakEffect()
		local g=aux.SelectUnselectGroup(rg,e,tp,5,5,aux.ChkfMMZ(1),1,tp,HINTMSG_REMOVE)
		Duel.Remove(g,POS_FACEUP,REASON_COST)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp=spg:Select(tp,1,1,nil)
		Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
	end
end