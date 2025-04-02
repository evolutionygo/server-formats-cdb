--召喚雲
--Summon Cloud
function c55375684.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Special Summon 1 "Cloudian" monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc55375684(c55375684,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(function(_,tp) return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 end)
	e2:SetTarget(c55375684.sptg)
	e2:SetOperation(c55375684.spop)
	c:RegisterEffect(e2)
end
c55375684.listed_series={SET_CLOUDIAN}
function c55375684.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(SET_CLOUDIAN) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c55375684.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c55375684.spfilter,tp,LOCATION_HAND|LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND|LOCATION_GRAVE)
end
function c55375684.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 or Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c55375684.spfilter),tp,LOCATION_HAND|LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	if #g>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 and g:GetFirst():IsSummonLocation(LOCATION_GRAVE) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end