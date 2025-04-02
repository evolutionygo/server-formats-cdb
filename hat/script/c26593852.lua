--Ａ・Ｏ・Ｊ カタストル
--Ally of Justice Catastor
function c26593852.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon procedure
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	--Destroy a non-DARK monster that battles with this card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc26593852(c26593852,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c26593852.destg)
	e1:SetOperation(c26593852.desop)
	c:RegisterEffect(e1)
end
function c26593852.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc and bc:IsFaceup() and bc:IsAttributeExcept(ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c26593852.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end