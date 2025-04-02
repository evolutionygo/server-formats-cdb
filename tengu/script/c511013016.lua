--拘束解放波 (Anime)
--Release Restraint Wave (Anime)
--cleaned up by MLD
function c511013016.initial_effect(c)
	--Destroy all Spells and Traps your opponent controls
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511013016(c511013016,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511013016.cost)
	e1:SetTarget(c511013016.target)
	e1:SetOperation(c511013016.activate)
	c:RegisterEffect(e1)
end
function c511013016.filter(c)
	return c:IsFaceup() and c:IsEquipSpell() and c:IsDestructable()
end
function c511013016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511013016.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511013016.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Destroy(g,REASON_COST)
end
function c511013016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetMatchingGroup(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,e:GetHandler())
	if chk==0 then return #dg>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,#dg,0,0)
end
function c511013016.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsSpellTrap,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end