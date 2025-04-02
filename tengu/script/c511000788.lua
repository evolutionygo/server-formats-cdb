--薔薇恋人 (Anime)
--Rose Lover (Anime)
local s,c511000788,alias=GetID()
function c511000788.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511000788(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c511000788.target)
	e1:SetOperation(c511000788.operation)
	c:RegisterEffect(e1)
end
c511000788.listed_series={0x123}
function c511000788.filter(c,e,tp)
	return c:IsSetCard(0x123) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000788.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000788.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000788.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000788.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end