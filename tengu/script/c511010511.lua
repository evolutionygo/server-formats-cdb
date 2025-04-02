--インフェルニティ・ミラージュ (Anime)
--Infernity Mirage (Anime)
function c511010511.initial_effect(c)
	--Special Summon 2 "Infernity" monsters from your Graveyard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511010511(c511010511,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010511.spcon)
	e1:SetCost(aux.selfreleasecost)
	e1:SetTarget(c511010511.sptg)
	e1:SetOperation(c511010511.spop)
	c:RegisterEffect(e1)
end
c511010511.listed_series={SET_INFERNITY}
function c511010511.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c511010511.filter(c,e,tp)
	return c:IsSetCard(SET_INFERNITY) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511010511.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511010511.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>1 and not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		and Duel.IsExistingTarget(c511010511.filter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511010511.filter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end
function c511010511.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local sg=Duel.GetTargetCards(e)
	if ft<#sg or (#sg>1 and Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)) then return end
	if #sg>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end