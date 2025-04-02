--Stardust Flash (Anime)
--星屑の残光
--scripted by: UnknownGuest
--fixed by MLD
--updated by Larry126
function c810000057.initial_effect(c)
	-- Special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc810000057(c810000057,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000057.target)
	e1:SetOperation(c810000057.activate)
	c:RegisterEffect(e1)
end
c810000057.listed_names={CARD_STARDUST_DRAGON}
function c810000057.filter(c,e,tp)
	return c:IsCode(CARD_STARDUST_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and c:GetFlagEffect(CARD_STARDUST_DRAGON)>0
end
function c810000057.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000057.filter,tp,0xff,0xff,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c810000057.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c810000057.filter,tp,0xff,0xff,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end