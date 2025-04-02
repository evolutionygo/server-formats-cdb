--死者の生還 (Anime)
--Return of the Doomed (Anime)
function c511000548.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000548.target)
	e1:SetOperation(c511000548.activate)
	c:RegisterEffect(e1)
end
function c511000548.filter(c,e,tp,tc511000548)
	return c:GetTurnID()==tc511000548 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c511000548.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc511000548=Duel.GetTurnCount()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511000548.filter(chkc,e,tp,tc511000548) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000548.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,tc511000548) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511000548.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc511000548=Duel.GetTurnCount()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511000548.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,tc511000548)
	if #tc>0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end