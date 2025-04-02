--魔界発冥界行きバス
--Tour Bus To Forbc89732524den Realms
function c89732524.initial_effect(c)
	--Search 1 non-LIGHT and non-DARK monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc89732524(c89732524,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c89732524.thtg)
	e1:SetOperation(c89732524.thop)
	c:RegisterEffect(e1)
end
function c89732524.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c89732524.thfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsAttributeExcept(ATTRIBUTE_LIGHT) and c:IsAttributeExcept(ATTRIBUTE_DARK) and c:IsAbleToHand()
end
function c89732524.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c89732524.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end