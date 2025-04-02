--マシンナーズ・ギアフレーム
--Machina Gearframe
function c42940404.initial_effect(c)
	aux.AddUnionProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),false)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc42940404(c42940404,2))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c42940404.stg)
	e1:SetOperation(c42940404.sop)
	c:RegisterEffect(e1)
end
c42940404.listed_series={0x36}
c42940404.listed_names={c42940404}
function c42940404.sfilter(c)
	return c:IsSetCard(0x36) and c:GetCode()~=c42940404 and c:IsMonster() and c:IsAbleToHand()
end
function c42940404.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42940404.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c42940404.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c42940404.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end