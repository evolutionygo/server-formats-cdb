--ライトロード・ハンター ライコウ
function c511003007.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511003007,0))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c511003007.target)
	e1:SetOperation(c511003007.operation)
	c:RegisterEffect(e1)
end

function c511003007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	-- Declaramos que se enviarán 3 cartas al Cementerio
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end

function c511003007.operation(e,tp,eg,ep,ev,re,r,rp)
	-- Al resolverse el efecto, Ryko ya está boca arriba.
	-- Aquí eliges si destruirás algo.
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(21502796,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
	-- Luego mandas las 3 cartas de tu Deck al Cementerio
	Duel.DiscardDeck(tp,3,REASON_EFFECT)
end
