--シンクロ・トランセンド (Manga)
--Synchro Transcend (Manga)
function c511000749.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCondition(c511000749.condition)
	e1:SetTarget(c511000749.target)
	e1:SetOperation(c511000749.activate)
	c:RegisterEffect(e1)
end
function c511000749.cfilter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and Duel.IsExistingMatchingCard(c511000749.filter,tp,LOCATION_EXTRA,0,1,nil,c:GetLevel(),e,tp)
end
function c511000749.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000749.cfilter,1,nil,e,tp) and ep==1-tp
end
function c511000749.filter(c,lv,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()==lv+1
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000749.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000749.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000749.cfilter,nil,e,tp)
	local rg=Group.CreateGroup()
	for tc in aux.Next(g) do
		rg:Merge(Duel.GetMatchingGroup(c511000749.filter,tp,LOCATION_EXTRA,0,nil,tc:GetLevel(),e,tp))
	end
	if rg:GetFirst() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp=rg:Select(tp,1,1,nil)
		Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
	end
end